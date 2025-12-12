from flask import Flask, request

app = Flask(__name__)

print(__name__)
# data storage...
in_memory_datastore = {
    "Alice Smith": {
        "name": "Alice Smith",
        "email": "asmith@gmail.com",
        "phone": 9801234567,
    },
    "Bob Smith": {
        "name": "Bob Smith",
        "email": "bsmith@gmail.com",
        "phone": 9801534567,
    },
}


@app.route("/")
def hello_world():
    return "Hello, There!"


# Text outputs...
@app.route("/contacts/text/getall")
def list_contacts():
    returnText = ""
    for value in in_memory_datastore.values():
        # returnText += (value["name"] + ", " +value["email"] + ", " + str(value["phone"]) +'\n')
        returnText += value["name"] + "\n"
    return returnText


@app.route("/contacts/text/details", methods=["GET"])
def get_contact():
    name = request.args.get("name")
    if name in in_memory_datastore.keys():
        value = in_memory_datastore[name]
        return value["name"] + ", " + value["email"] + ", " + str(value["phone"]) + "\n"
    else:
        return "Error: Contact {} not found!".format(name), 404


@app.route("/contacts/text/delete/", methods=["GET"])
def delete_contact():
    name = request.args.get("name")
    if name in in_memory_datastore.keys():
        in_memory_datastore.pop(name)
        return "Contact {} is deleted!".format(name)
    else:
        return "Error: Contact {} not found!".format(name), 404


@app.route("/contacts/text/add", methods=["GET", "POST"])
def add_contact():
    returnData = create_new_contact(request)
    return returnData[0], returnData[1]


def create_new_contact(new_contact):
    name = new_contact.form["name"]
    email = new_contact.form["email"]
    phone = new_contact.form["phone"]
    if name not in in_memory_datastore.keys():
        in_memory_datastore[name] = {"name": name, "email": email, "phone": int(phone)}
        returnStr = "Contact created: {}, {}, {}".format(name, email, phone)
        return {"info": returnStr}, 200
    else:
        returnStr = "Error: Contact {} already exists!".format(name)
        return {"error": returnStr}, 408


# JSON outputs...
@app.route("/contacts/json/getall")
def list_json_contacts():
    contacts = []
    for cont in in_memory_datastore.values():
        contacts.append({"name": cont["name"]})
    return {"contacts": contacts}, 200


@app.route("/contacts/json/details", methods=["GET"])
def get_json_contact():
    name = request.args.get("name")
    if name in in_memory_datastore.keys():
        value = in_memory_datastore[name]
        return value, 200
    else:
        returnStr = "Error: Contact {} not found!".format(name)
        return {"error": returnStr}, 404


@app.route("/contacts/json/delete/", methods=["GET"])
def delete_json_contact():
    name = request.args.get("name")
    if name in in_memory_datastore.keys():
        in_memory_datastore.pop(name)
        returnStr = "Contact {} is deleted!".format(name)
        return {"info": returnStr}, 200
    else:
        return {"error": "Error: Contact not found!"}, 404


@app.route("/contacts/json/add", methods=["GET", "POST"])
def add_json_contact():
    return create_new_contact(request)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8888)
    # OR for production with Let's Encrypt:
    # app.run(
    #     host="0.0.0.0",
    #     port=8888,
    #     ssl_context=(
    #         "/etc/letsencrypt/live/apis.sakibnm.work/fullchain.pem",
    #         "/etc/letsencrypt/live/apis.sakibnm.work/privkey.pem",
    #     ),
    # )
