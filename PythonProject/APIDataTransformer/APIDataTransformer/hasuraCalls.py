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

def insertAlarmsData(apiCaller: APICaller, data: dict):
    deviceUUID = data.get("frameDeviceIdentifier")
    headers = apiCaller.getTokenHeaders()
    alarms = apiCaller.sendGetRequest(apiCaller.generateStatsURL(deviceUUID, "/alarms"), headers)
    id = data.get("id")
    frameUUID = data.get()
    headers = apiCaller.getTokenHeaders()
    apiCaller.sendPostRequest(apiCaller.generateHasuraURL(""), data, headers)

def insertAlertsData(apiCaller: APICaller, data: dict):
    headers = apiCaller.getTokenHeaders()

