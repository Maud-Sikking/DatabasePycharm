import os, base64, requests, json
from dotenv import load_dotenv

# Class die verantwoordelijk is voor het versturen van requests en ook de authenticatieheaders opstelt
class APICaller:
    def __init__(self) -> None:
        load_dotenv()
     
    def getBaseData(self) -> list[dict]:
        data: list = list()
        headers = self.getBasicAuthHeaders()
        page0 = self.sendGetRequest(os.getenv("DEVICES_URL"), headers)
        data.extend(page0.get("content"))
        nr_pages = page0.get("page").get("totalPages")
        for i in range(1, nr_pages + 1): # voor elke pagina behalve pagina 0 want die hebben we al opgevraagd
            data.extend(self.sendGetRequest(os.getenv("DEVICES_URL") + "?page=" + str(i), headers).get("content"))
        return data
     
    def generateBase64Auth(self) -> str:
        USER: str = os.getenv("API_USERNAME")
        PASSWORD: str = os.getenv("PASSWORD")
        user_pw_bytes = f"{USER}:{PASSWORD}".encode()
        bytes = base64.b64encode(user_pw_bytes)
        return bytes.decode()
        
    def getToken(self) -> str:
        return os.getenv("TOKEN")
    
    def getBasicAuthHeaders(self) -> dict:
        return {"Authorization": "Basic " + self.generateBase64Auth()}
    
    def getTokenHeaders(self) -> dict:
        return {"Authorization": "Bearer " + self.getToken()}
    
    def getHasuraHeaders(self) -> dict:
        return {"x-hasura-admin-secret": os.getenv("HASURA_SECRET")} #heb ik veranderd, was eerst een komma ipv een dubbele punt
    
    def sendGetRequest(self, URL: str, headers: dict) -> str:
        res = requests.get(URL, headers=headers)
        return json.loads(res.text)
    
    def sendPostRequest(self, URL: str, body: str, headers: dict) -> str:
        res = requests.post(URL, json = body, headers=headers)
        return res.json()
    
    def sendDeleteRequest(self, URL: str, headers: dict) -> str:
        res = requests.delete(URL, headers=headers)
        return res.json()
    
    # relativeURL is het hasura endpoint dat je wil aanroepen. Bijv: device/insert
    def generateHasuraURL(self, relativeURL: str) -> str:
        return os.getenv("HASURA_BASEURL") + relativeURL
    
    # relativeURL is bijv "/alarms"
    def generateStatsURL(self, UUID: str, relativeURL: str) -> str:
        return os.getenv("STATS_URL") + UUID + relativeURL