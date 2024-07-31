Deploy and Automate PostgreSQL Database Server

This project automates the deployment and configuration of a PostgreSQL database server on an Ubuntu instance hosted on AWS using Ansible. It also sets up regular backups for the database.
Project Structure

    inventory.ini: Ansible inventory file defining the AWS Ubuntu instance and connection details.
    deploy_database.yml: Ansible playbook that handles the installation, configuration, and backup automation of PostgreSQL.
    templates/pg_hba.conf.j2: Jinja2 template for PostgreSQL configuration.
    scripts/backup.sh: Backup script for PostgreSQL databases.

Requirements

    Ansible installed on your local machine.
    An AWS Ubuntu instance.
    PostgreSQL 12 or the version specified in the deploy_database.yml playbook.

Setup
1. Prepare the Inventory File

Create an inventory.ini file with the following content:

ini

[database]
your_ubuntu_instance ansible_host=your_instance_ip

[database:vars]
ansible_user=ubuntu
ansible_ssh_private_key_file=/path/to/your/private/key.pem

Replace your_ubuntu_instance, your_instance_ip, and /path/to/your/private/key.pem with your actual details.
2. Create the Ansible Playbook

Save the following playbook as deploy_database.yml:

yaml

---
- hosts: database
  become: yes
  vars:
    postgres_version: 12
    postgres_db: my_database
    postgres_user: my_user
    postgres_password: my_password
    backup_dir: /var/backups/postgresql
    postgres_conf_path: /etc/postgresql/{{ postgres_version }}/main

  pre_tasks:
    - name: Ensure apt cache is up to date
      apt:
        update_cache: yes
        cache_valid_time: 3600

  tasks:
    - name: Install PostgreSQL and related packages
      apt:
        name: 
          - "postgresql-{{ postgres_version }}"
          - "postgresql-contrib-{{ postgres_version }}"
        state: present

    - name: Ensure PostgreSQL service is started and enabled
      systemd:
        name: postgresql
        state: started
        enabled: yes

    - name: Create PostgreSQL database
      postgresql_db:
        name: "{{ postgres_db }}"
        state: present

    - name: Create PostgreSQL user
      postgresql_user:
        name: "{{ postgres_user }}"
        password: "{{ postgres_password }}"
        db: "{{ postgres_db }}"
        priv: "ALL"
        state: present

    - name: Set PostgreSQL password encryption method to md5
      postgresql_pg_hba:
        dest: "{{ postgres_conf_path }}/pg_hba.conf"
        type: "host"
        database: "{{ postgres_db }}"
        user: "{{ postgres_user }}"
        address: "0.0.0.0/0"
        method: "md5"

    - name: Allow remote connections to PostgreSQL
      lineinfile:
        path: "{{ postgres_conf_path }}/postgresql.conf"
        regexp: '^#?listen_addresses =.*'
        line: "listen_addresses = '*'"
        state: present

    - name: Create backup directory
      file:
        path: "{{ backup_dir }}"
        state: directory
        owner: postgres
        group: postgres
        mode: '0755'

    - name: Deploy backup script
      copy:
        src: scripts/backup.sh
        dest: /usr/local/bin/backup.sh
        mode: '0755'

    - name: Set up cron job for backups
      cron:
        name: "PostgreSQL Backup"
        user: postgres
        job: "/usr/local/bin/backup.sh {{ postgres_db }} {{ backup_dir }} > /dev/null 2>&1"
        minute: "0"
        hour: "2"
        state: present

  handlers:
    - name: restart postgresql
      systemd:
        name: postgresql
        state: restarted

  post_tasks:
    - name: Confirm PostgreSQL service is running
      systemd:
        name: postgresql
        state: started

3. Create the Backup Script

Save the following script as scripts/backup.sh:

bash

#!/bin/bash

DB_NAME=$1
BACKUP_DIR=$2
DATE=$(date +%F_%H-%M-%S)
BACKUP_FILE="$BACKUP_DIR/$DB_NAME-$DATE.sql"
LOG_FILE="$BACKUP_DIR/backup.log"

# Ensure backup directory exists
mkdir -p "$BACKUP_DIR"

# Perform the backup and log output
echo "Starting backup for database $DB_NAME at $DATE" >> $LOG_FILE
pg_dump -U postgres $DB_NAME > $BACKUP_FILE 2>> $LOG_FILE

if [ $? -eq 0 ]; then
    echo "Backup successful: $BACKUP_FILE" >> $LOG_FILE
else
    echo "Backup failed for database $DB_NAME" >> $LOG_FILE
fi

# Optional: Remove backups older than 7 days
find $BACKUP_DIR -type f -name "*.sql" -mtime +7 -exec rm {} \; >> $LOG_FILE 2>&1

4. Create the Jinja2 Template

If you need custom PostgreSQL configurations, create templates/pg_hba.conf.j2 with the following content:

ini

# PostgreSQL Client Authentication Configuration File
# ===================================================
# TYPE  DATABASE        USER            ADDRESS                 METHOD

# "local" is for Unix domain socket connections only
local   all             all                                     peer
# IPv4 local connections:
host    all             all             127.0.0.1/32            md5
# IPv6 local connections:
host    all             all             ::1/128                 md5

# Allow access to the specified database and user from any IP address
host    {{ postgres_db }} {{ postgres_user }} 0.0.0.0/0 md5

5. Run the Ansible Playbook

Execute the Ansible playbook to deploy and configure PostgreSQL:

bash

ansible-playbook -i inventory.ini deploy_database.yml

Troubleshooting

    Image Does Not Exist: Ensure the Docker image is built and tagged correctly.
    Permission Issues: Verify that the playbook and script files have the appropriate permissions.
    PostgreSQL Service Not Starting: Check the logs for errors and ensure PostgreSQL is properly configured.

Feel free to adjust configurations, passwords, and paths according to your environment and security requirements.
