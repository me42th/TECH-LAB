# DEVICE TOKEN

> Um identificador único universal (do inglês universally unique identifier - UUID) é um número de 128 bits usado para identificar informações em sistemas de computação.[1] O termo identificador único global (globally unique identifier - GUID) também é utilizado. O significado de cada bit é definido por qualquer uma das diversas variantes. 
>>**Texto hexadecimal com caracteres hífen inseridos. Por exemplo:**

- 123e4567-e89b-12d3-a456-426655440000

## SHELL

1. npm install @ionic-native/unique-device-id
2. npm install cordova-plugin-uniquedeviceid

## CODE

```
constructor(private uuid: UniqueDeviceID) {
    this.uuid.get()
    .then( value => this.data = '' + value)
    .catch(value => this.error = '' + value);
  }
```

