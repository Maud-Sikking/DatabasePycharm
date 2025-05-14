# contains all the hasura calls
from APICaller import APICaller

def insertBasicDeviceData(apiCaller: APICaller, data: dict):
    # bereid je data voor, zet het in het juiste format, etc
    id = data.get("id")
    frameDeviceIdentifier = data.get("frameDeviceIdentifier")
    firstRegistration = data.get("firstRegistration")
    lastRegistration = data.get("lastRegistration")
    totalRegistrations = data.get("totalRegistrations")
    # zie hier dictionaries (JSON in python): https://www.w3schools.com/python/python_dictionaries.asp

    body = {
        "query": """
               mutation InsertDevice($device: devices_insert_input!) {
                 insert_devices_one(object: $device, on_conflict: {
                   constraint: devices_frameDeviceIdentifier_key,
                   update_columns: [id, firstRegistration, lastRegistration, totalRegistrations]
                 }) {
                   frameDeviceIdentifier 
                 }
               }
           """,
        "variables": {
            "device": {
                "id": id,
                "frameDeviceIdentifier": frameDeviceIdentifier,
                "firstRegistration": firstRegistration,
                "lastRegistration": lastRegistration,
                "totalRegistrations": totalRegistrations
            }
        }
    }

    headers = apiCaller.getHasuraHeaders()
    response = apiCaller.sendPostRequest(apiCaller.generateHasuraURL(""), body, headers)
    print(response)
# TODO: hasura calls aanmaken

def insertAlarmsData(apiCaller: APICaller, deviceUUID: str, alarms: list[dict]):

    if not alarms:
        print(f"Geen alarms voor device {deviceUUID}")
        return

    rows = []
    for alarm in alarms:
        response = alarm.get("responses")[0] if alarm.get("responses") else {}

        rows.append({
            "id": alarm.get("id"),
            "frameUUID": deviceUUID,
            "created": alarm.get("created"),
            "ended": alarm.get("ended"),
            "id_respons": response.get("id"),
            "reaction_respons": response.get("reaction"),
            "timestamp_respons": response.get("timestamp")
        })

    body = {
        "query": """
               mutation InsertAlarms($alarms: [alarms_insert_input!]!) {
                 insert_alarms(objects: $alarms) {
                   affected_rows
                 }
               }
           """,
        "variables": {
            "alarms": rows
        }
    }
    headers = apiCaller.getHasuraHeaders()
    response = apiCaller.sendPostRequest(apiCaller.generateHasuraURL(""), body, headers)
    print(f"Alarms response voor {deviceUUID}: {response}")

def insertAlertsData(apiCaller: APICaller, deviceUUID: str, alerts: list[dict]):

    if not alerts:
        print(f"Geen alerts voor device {deviceUUID}")
        return

    rows = []
    for alert in alerts:

        rows.append({
            "id": alert.get("id"),
            "frameUUID": deviceUUID,
            "type": alert.get("type"),
            "created": alert.get("created"),
            "solved": alert.get("solved"),
        })

    body = {
        "query": """
               mutation InsertAlerts($alerts: [alerts_insert_input!]!) {
                 insert_alerts(objects: $alerts, on_conflict: {
                   constraint: alerts_id_key,
                   update_columns: [frameUUID, type, created, solved]}) 
                   {
                   affected_rows
                 }
               }
           """,
        "variables": {
            "alerts": rows
        }
    }
    headers = apiCaller.getHasuraHeaders()
    response = apiCaller.sendPostRequest(apiCaller.generateHasuraURL(""), body, headers)
    print(f"alerts response voor {deviceUUID}: {response}")

def insertMessagesData(apiCaller: APICaller, deviceUUID: str, messages: list[dict]):
    if not messages:
        print(f"Geen messages voor device {deviceUUID}")
        return

    if not isinstance(messages, list):
        print(f"Ongeldige messages response voor {deviceUUID}: {messages}")
        return

    rows = []
    for message in messages:

        if not isinstance(message, dict):
            print(f"Ongeldig message-object: {message}")
            continue  # sla dit item over

        response = message.get("response") or {}

        rows.append({
            "id": message.get("id"),
            "frameUUID": deviceUUID,
            "originId": message.get("originId"),
            "sent": message.get("sent"),
            "id_respons": response.get("id"),
            "created_respons": response.get("created")
        })

    body = {
        "query": """
               mutation InsertMessages($messages: [messages_insert_input!]!) {
                 insert_messages(objects: $messages) {
                   affected_rows
                 }
               }
           """,
        "variables": {
            "messages": rows
        }
    }
    headers = apiCaller.getHasuraHeaders()
    response = apiCaller.sendPostRequest(apiCaller.generateHasuraURL(""), body, headers)
    print(f"messages response voor {deviceUUID}: {response}")

def insertPhotosData(apiCaller: APICaller, deviceUUID: str, photos: list[dict]):

    if not photos:
        print(f"Geen foto's voor device {deviceUUID}")
        return

    if not isinstance(photos, list):
        print(f"Ongeldige photos response voor {deviceUUID}: {photos}")
        return

    rows = []
    for photo in photos:

        rows.append({
            "id": photo.get("id"),
            "frameUUID": deviceUUID,
            "sent": photo.get("sent"),
        })

    body = {
        "query": """
               mutation InsertPhotos($photos: [photos_insert_input!]!) {
                 insert_photos(objects: $photos, on_conflict: {
                   constraint: photos_id_key,
                   update_columns: [frameUUID, sent]}) {
                   affected_rows
                 }
               }
           """,
        "variables": {
            "photos": rows
        }
    }
    headers = apiCaller.getHasuraHeaders()
    response = apiCaller.sendPostRequest(apiCaller.generateHasuraURL(""), body, headers)
    print(f"photos response voor {deviceUUID}: {response}")

def insertCallsData(apiCaller: APICaller, deviceUUID: str, calls: list[dict]):

    if not calls:
        print(f"Geen calls voor device {deviceUUID}")
        return

    rows = []
    for call in calls:

        rows.append({
            "id": call.get("id"),
            "frameUUID": deviceUUID,
            "type": call.get("type"),
            "created": call.get("created"),
            "started": call.get("started"),
            "ended": call.get("ended"),
        })

    body = {
        "query": """
               mutation InsertCalls($calls: [calls_insert_input!]!) {
                 insert_calls(objects: $calls, on_conflict: {
                   constraint: calls_id_key,
                   update_columns: [frameUUID, type, created, started, ended]}) 
                   {
                   affected_rows
                 }
               }
           """,
        "variables": {
            "calls": rows
        }
    }
    headers = apiCaller.getHasuraHeaders()
    response = apiCaller.sendPostRequest(apiCaller.generateHasuraURL(""), body, headers)
    print(f"calls response voor {deviceUUID}: {response}")
