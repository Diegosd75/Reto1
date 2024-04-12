from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/process', methods=['POST'])
def process_event():
    data = request.json
    # Aquí se podría agregar lógica para procesar el evento
    print("Processing event:", data)
    return jsonify({"status": "processed"}), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)