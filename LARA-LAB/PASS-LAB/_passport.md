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

curl -H  "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjE0YzJiYzBhZDAxMmFlOWEzNmVlNDU1OTU1ZGU2YWJmZmZhZGYwZDBlNjQ4NjMyMDFjMzg1NTZkZjFmNjUxOTI1NDg2NDM1ZTc2NWRhYmY2In0.eyJhdWQiOiI1IiwianRpIjoiMTRjMmJjMGFkMDEyYWU5YTM2ZWU0NTU5NTVkZTZhYmZmZmFkZjBkMGU2NDg2MzIwMWMzODU1NmRmMWY2NTE5MjU0ODY0MzVlNzY1ZGFiZjYiLCJpYXQiOjE1NjU5NTc0MzksIm5iZiI6MTU2NTk1NzQzOSwiZXhwIjoxNTk3NTc5ODM5LCJzdWIiOiI1Iiwic2NvcGVzIjpbXX0.h0VTPzw1wDZMP2AeZ4flVeZunHupyj-szg9ouqS5384edSvvEdHp1YmjILdChyR-YHFiY26zGrkwOFvVlcRHYm4Uoz_Ct89jyIY7fq3Cj_KwRgrL1HYHvCCCqmIx1-z5H-qDDFwa9bXZ1ynvuEbnpz-VjxnC1ZASJ8IQz6FYZ0AKfaHYJbjro7DsgONDspi1vKVsmdOGzaX2u2u2xTYMp-otLF111I5HTVFHN7bmRsNSrau_Ec3yqwpA4umGoei_KhTGjDWTL-5CGB9LDyZJCL0ZXEWqmIS6sYIfkkLInJtU230Oe4pV8x5XU2QIkFpoDQKHBdbfuRhTrsRqkX_Ab-kczWWPqR-Q_lSo_6cc5FKdDjX_UQTd96lM47WNAaWj22Y7czBfK2iNGwSjTRVR-077YYeSIZb5BDUYka18WdBMylTlI2H7Ix4LRWH5_Stm7HmpLcoMpfS6G41rE3TzDjp97jOj12cVzpLToJsUxm_fh3tiTmFYK-ukJM2PtgoNDv8kQLcr28MQONBh5mK9ijIgiRRKiBZjEHPgjRFObKNkaiHFHm2wUYzXs8BmODj-ypDeR30TChWyev6idapa6lhzMQOXg2ydRhDSGzNYztTiTyqOD4H3GnUTE-qTAWI6yk9tVx8b0lOCM9WmpLKA1CtoY-kqsOZ4GSkdBZS5IUM" 10.0.0.219:8000/api/autors

## SHELL

```
php artisan passport:client --password

 What should we name the password grant client? [Laravel Password Grant Client]:
 > IONIC

Password grant client created successfully.
Client ID: 4
Client secret: J73znpQnZ8EI9CoxwgKqfPNiuKbpMU5siye4PSEu
```
