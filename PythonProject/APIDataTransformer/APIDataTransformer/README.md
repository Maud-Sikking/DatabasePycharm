Runnen: 
1. Open een terminal in deze folder
2. Run `python main.py`
- Alternatief: open in PyCharm en run op de gebruikelijke manier

TODO:
1. Vul .env aan met de hasura baseURL en het hasura secret
2. Vul het file hasuraCalls.py aan met alle hasura calls die je nodig hebt (zie het voorbeeld voor het juiste format)
3. Zet deze hasura calls op de juiste plek (zie comments) in main.py

De APICaller class:
- Verantwoordelijk voor het versturen van get, post en delete requests
- Verantwoordelijk voor het opstellen van de headers
- Verantwoordelijk voor het opstellen van URLs naar de APIs en Hasura o.b.v. relative URLs

N.B.: de parameters zijn typed. Dus `data: dict` betekent niets meer dan de parameter heet data en is van het type dict (dict is de Python equivalent van JSON). Door parameters te typen is het makkelijk om bij te houden wat je verwacht en ook makkelijker om fouten te vinden in het aanroepen van functies. Het is *niet verplicht*, ook niet als een deel van de parameters wel typed is.