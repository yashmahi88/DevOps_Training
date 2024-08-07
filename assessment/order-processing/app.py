from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/order', methods=['POST'])
def create_order():
    data = request.json
    return jsonify({"status": "Order received", "order": data}), 201

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
