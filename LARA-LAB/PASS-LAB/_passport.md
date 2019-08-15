# PASSPORT TIPS

## POSTMAN

> OBTER TOKEN
> URL: 127.0.0.1:8000/oauth/token
> METHOD: POST
> HEADERS: Accept : application/json Content-Type : application/json
> BODY: raw
```
{
    "grant_type" : "password",
    "client_id" : "5",
    "client_secret" : "ijDV4ulrWnxCUpFED5UEBSY27xXW3Lwn7auJUXUI",
    "username" : "d@ad.asdd",
    "password" : "123123"
}
```

> USAR TOKEN
> URL: 127.0.0.1:8000/api/
> METHOD: GET/POST/PUT/DELETE
> HEADERS: Accept : application/json Content-Type : application/json Authorization: Bearer {TOKEN}
> BODY: raw
```
{
    "var" : "value"
}
```

> OBTER TOKEN VIA REFRESH
> URL: 127.0.0.1:8000/oauth/token
> METHOD: POST
> HEADERS: Accept : application/json Content-Type : application/json
> BODY: raw
{
    "grant_type" : "refresh_token",
    "client_id" : "5",
    "client_secret" : "ijDV4ulrWnxCUpFED5UEBSY27xXW3Lwn7auJUXUI",
    "refresh_token" : "def502001e29b0074b98a2f3f7230cc6bc57203e0139834e2f239dd9b03debce8098078ad39e471de49575729c43ad057122af9be41f3fa83fa15628b5f16e1da2a8d9af3dcf51b14f89560626068724aa998f4ea11be2501a0e98e9586b58ab154ae3f5c0c25f50237e54ff35b8240b9764ff1e5175b687d2623bd9ae0cb19d826809dfe7b8ed280ab91ab28d16f385df65633f88d5e9a40ad3fffa17d8301d9fca34b0759643ba9b82feddbf60cca03845e1a4ee51f82662e33d284eec2249d46188a2a10ecd2e36615ef955f35c481042acd77fb99de8aee7c0da6a6ad91ba089454b1593ac914c7f05d5723b6bd7bbe91a69b057b26257f59472285f71bead31e4f0793f2e00cba0c63893e9cd65d5ea750f4452cca963d15009bc8f744b5e134e19583527f6a143f49fe78eea24eff5e9c5ad0546fb14084259af915fe91667ad8183309abca632d3d7231748bb60bcf2ac38030b27f6326a555fe066ce58"
}


## CURL

curl -d "email=d@ad.asdd&password=123123&name=David" -H "Accept: application/json" -X POST localhost:8000/api/cadastro

curl -d "grant_type=password&client_id=4&client_secret=J73znpQnZ8EI9CoxwgKqfPNiuKbpMU5siye4PSEu&username=d@ad.asdd&password=123123" -H "Accept: application/json" -X POST localhost:8000/oauth/token

curl  "Authorization=Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImM0ZDI5MDM1MjQ3ZTQ0OTkwZWZkNWI3MjBiZjExZGQ0NzJjOGFjMGExMzA5YTllOTU5YTY1NWMyYzVjNDdiM2IxNmE1ZDg3NGFhMTNlZjM3In0.eyJhdWQiOiI0IiwianRpIjoiYzRkMjkwMzUyNDdlNDQ5OTBlZmQ1YjcyMGJmMTFkZDQ3MmM4YWMwYTEzMDlhOWU5NTlhNjU1YzJjNWM0N2IzYjE2YTVkODc0YWExM2VmMzciLCJpYXQiOjE1NjU4OTM3MTEsIm5iZiI6MTU2NTg5MzcxMSwiZXhwIjoxNTk3NTE2MTExLCJzdWIiOiI1Iiwic2NvcGVzIjpbXX0.IquOm1qnPSmQ85YeMcF23tqYdcBaBWg7KJxKz9lS4skRs1VC92kwXNjNAnwdENdeHiUVVcXZGZWevLQgHuHtwBhfwQ-CDMxg-dbRWeJmjrerObTe2PPnxy1-xn7_GglsnAqppuv1X1dHkIJF8eHfiY_uoR0hH-mqWnJ0ZZkJ-Yce5ZLxQQ8_gIYXAwCJ3P3Ar4mQQTZlMK7f6EB4Af_dSg0RrrQLS9-q1zwaQXOuXqlQg914WlNBdt4TvRqaDtmAv7Nitn6PyL8U6d4KGcdKS4AK5hYPJ2U_aagTyyUVmnZkd0_S8hBmaXVwj17uySE2jFPpxFeUP5Z-J556L5Jqu5V8go9_w6gghnVs75rsyRodqSkDwldgVnqSww21OJuqiDynRHrmvI0bOQDIkOZz2ej-NQcAyjhGPagHhY5m80SfmChsru1RbKyCjqRpazWy6UXDE9FrVjC--RWIGotKqWDK_np4zXUPdpuO07PwBk0STrzm9dVgUZvyRP_R8igEvg89th_-HGtuvUvfUluntAzyeU1zpzomrHstj_Qr3n81BXAjoV5jO6yFWYa8jVR9RHY9ZV_o-1tV7O-DVrTaQCfxF-_mKlF71o6hs2pmJ_QyrPS690BEgpMCTZ1B1JMe45-zDYi47hKCpJAmB6us1XoMNzjCPwOtz0R80YctwIc" 10.0.0.219:8000

## SHELL

```
php artisan passport:client --password

 What should we name the password grant client? [Laravel Password Grant Client]:
 > IONIC

Password grant client created successfully.
Client ID: 4
Client secret: J73znpQnZ8EI9CoxwgKqfPNiuKbpMU5siye4PSEu
```
