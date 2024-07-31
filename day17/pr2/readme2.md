Certainly! Below is a `README.md` file outlining the steps to set up and configure a multi-tier web application stack with PostgreSQL and a web server using Ansible.

---

# Multi-Tier Web Application Stack Deployment

## Overview

This project automates the deployment and configuration of a multi-tier web application stack. It includes:

- **Database Server**: A PostgreSQL database server.
- **Application Server**: A web server (Nginx) hosting a web application.
- **Application Deployment**: The web application is configured to connect to the PostgreSQL database.

The setup is automated using Ansible, including database initialization, web server configuration, and application deployment.

## Prerequisites

- **Ansible**: Ensure Ansible is installed on the control node.
- **SSH Access**: SSH access to both the database and application servers with appropriate private keys.
- **Ubuntu Instances**: Two Ubuntu instances, one for the database and one for the application server.

## Project Structure

- **Ansible Inventory File**: `inventory.ini`
- **Ansible Playbook**: `deploy_multitier_stack.yml`
- **Jinja2 Template**: `templates/app_config.php.j2`
- **Application Files**: `files/index.html`
- **README.md**: This file.

## Files and Their Content

### Inventory File

**Filename:** `inventory.ini`

**Content:**

```ini
[database]
db_server ansible_host=13.56.224.86 ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/ansible-worker.pem

[application]
app_server ansible_host=13.56.224.86 ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/ansible-worker.pem
```

### Ansible Playbook

**Filename:** `deploy_multitier_stack.yml`

**Content:**

```yaml
---
- hosts: database
  become: yes
  vars:
    postgres_version: 12
    postgres_db: app_db
    postgres_user: app_user
    postgres_password: app_password

  tasks:
    - name: Install PostgreSQL
      apt:
        name: "postgresql-{{ postgres_version }}"
        state: present

    - name: Create PostgreSQL database
      postgresql_db:
        name: "{{ postgres_db }}"
        state: present

    - name: Create PostgreSQL user
      postgresql_user:
        db: "{{ postgres_db }}"
        name: "{{ postgres_user }}"
        password: "{{ postgres_password }}"
        priv: "ALL"
        state: present

    - name: Configure PostgreSQL access
      template:
        src: templates/pg_hba.conf.j2
        dest: /etc/postgresql/{{ postgres_version }}/main/pg_hba.conf
        mode: 0644
      notify: restart postgresql

  handlers:
    - name: restart postgresql
      systemd:
        name: postgresql
        state: restarted

- hosts: application
  become: yes
  vars:
    web_root: /var/www/html
    app_config_template: templates/app_config.php.j2
    db_host: "{{ hostvars['database']['ansible_host'] }}"
    db_name: app_db
    db_user: app_user
    db_password: app_password

  tasks:
    - name: Install Nginx
      apt:
        name: nginx
        state: present

    - name: Deploy web application
      copy:
        src: files/index.html
        dest: "{{ web_root }}/index.html"
        mode: 0644

    - name: Deploy application configuration
      template:
        src: "{{ app_config_template }}"
        dest: "{{ web_root }}/app_config.php"
        mode: 0644
```

### Jinja2 Template

**Filename:** `templates/app_config.php.j2`

**Content:**

```php
<?php
// Database configuration
define('DB_HOST', '{{ db_host }}');
define('DB_NAME', '{{ db_name }}');
define('DB_USER', '{{ db_user }}');
define('DB_PASSWORD', '{{ db_password }}');

// Other configurations
?>
<!DOCTYPE html>
<html>
<head>
    <title>My Web Application</title>
</head>
<body>
    <h1>Welcome to My Web Application</h1>
    <p>This is the landing page.</p>
</body>
</html>
```

### Application Files

**Filename:** `files/index.html`

**Content:**

```html
<!DOCTYPE html>
<html>
<head>
    <title>My Web Application</title>
</head>
<body>
    <h1>Welcome to My Web Application</h1>
    <p>This is the landing page.</p>
</body>
</html>
```

## Setup and Execution

1. **Prepare the Environment**:
   - Ensure SSH access to both servers and the appropriate private key files are in place.
   - Install Ansible on the control node.

2. **Configure the Inventory File**:
   - Edit `inventory.ini` to include the correct IP addresses and SSH details for your database and application servers.

3. **Prepare Templates and Files**:
   - Place the Jinja2 template (`app_config.php.j2`) in the `templates/` directory.
   - Place the static HTML file (`index.html`) in the `files/` directory.

4. **Run the Ansible Playbook**:
   Execute the playbook using the following command:

   ```bash
   ansible-playbook -i inventory.ini deploy_multitier_stack.yml
   ```

5. **Verify Deployment**:
   - **Database Server**: Verify PostgreSQL is installed, the database and user are created.
   - **Application Server**: Verify Nginx is installed, and the web application is accessible.



