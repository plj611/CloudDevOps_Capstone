from flask import Flask, request
from flask import jsonify

app = Flask(__name__)
fp = open("config.txt", encoding="utf-8")
for line in fp.readlines():
    tmp = line.split('=')
    if tmp[0] == 'CURRENT':
        CURRENT_VER = tmp[1].rstrip()
    elif tmp[0] == 'LAST':
        LAST_VER = tmp[1].rstrip()

@app.route("/", methods=["GET"])
def check_status():
    return jsonify({'success': True,
                    'app_ver': CURRENT_VER})

@app.route("/get_ip", methods=["GET"])
def get_my_ip():
    return jsonify({'ip': request.environ['REMOTE_ADDR'],
                    'success': True})

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8080, debug=True)