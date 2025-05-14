from APIDataTransformer.APIDataTransformer.hasuraCalls import insertBasicDeviceData
from PropagatingThread import PropagatingThread
from APICaller import APICaller
import hasuraCalls

ALARMS: str = "/alarms"
ALERTS: str = "/alerts"
MESSAGES: str = "/messages"
PHOTOS: str = "/photos"
CALLS: str = "/calls"

def main():
    # init APICaller
    apiCaller = APICaller()
    # Get all devices
    baseData: dict = apiCaller.getBaseData()
    #  baseData = baseData[:500] kun je gebruiken om maar een deel van de data te gebruiken. Bijv [:10] voor de eerste 10 devices
    
    # split list into chunks of 10
    sub_list_length = 10
    sub_lists = [
        baseData[i : i + sub_list_length]
        for i in range (0, len(baseData), sub_list_length)
    ]
    
    # run calls for devices per 10, wait for all 10 to complete to spawn another 10 callsequences
    for sub_list in sub_lists:
        processingJobs = []
        for device in sub_list:
            process = PropagatingThread(target=processDevice, args=(apiCaller, device,))
            process.daemon = True
            processingJobs.append(process)
            process.start()
        for job in processingJobs:
            job.join() # zorgt ervoor dat alle 10 de taken afgerond zijn voordat het programma aan de volgende 10 begint (voorkomt DOS-like gedrag, de gevolgen daarvan en oververhitte laptops)
    
def processDevice(apiCaller: APICaller, device: dict) -> None:
    # insert basic device info
    hasuraCalls.insertBasicDeviceData(apiCaller, device)
    
    deviceUUID = device.get("frameDeviceIdentifier")
    headers = apiCaller.getTokenHeaders()
    alarms = apiCaller.sendGetRequest(apiCaller.generateStatsURL(deviceUUID, ALARMS), headers)
    alerts = apiCaller.sendGetRequest(apiCaller.generateStatsURL(deviceUUID, ALERTS), headers)
    messages = apiCaller.sendGetRequest(apiCaller.generateStatsURL(deviceUUID, MESSAGES), headers)
    photos = apiCaller.sendGetRequest(apiCaller.generateStatsURL(deviceUUID, PHOTOS), headers)
    calls = apiCaller.sendGetRequest(apiCaller.generateStatsURL(deviceUUID, CALLS), headers)
    print("alarms")
    print(alarms)
    print("alerts")
    print(alerts)
    print("messages")
    print(messages)
    print("photos")
    print(photos)
    print("calls")
    print(calls)
    # TODO: maak hasuraCalls functies aan en roep die aan om de data in de database te krijgen
    hasuraCalls.insertAlarmsData(apiCaller, deviceUUID, alarms)
    hasuraCalls.insertAlertsData(apiCaller, deviceUUID, alerts)
    hasuraCalls.insertMessagesData(apiCaller, deviceUUID, messages)
    hasuraCalls.insertPhotosData(apiCaller, deviceUUID, photos)
    hasuraCalls.insertCallsData(apiCaller, deviceUUID, calls)
        
main()