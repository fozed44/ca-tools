# ca-tools
---
### Helper scripts to:
- Create a certificate authority.
- Given a certificate authority, create a CA-signed certificate for a given domain.


# To use ca-tools 
---

### Create the CA
- run ./GenerateCA [filename].pfx
- This will be required ONE time only. The CA generated by GenerateCA will be placed at ca/[filename].pfx. All future uses of GenerateCert should use the file generated in this step.

### Create a cert signed by the CA for a given domain
- Requries a _single_  pfx file in ./ca.
- run ./bash/GenerateCert [domainname]
- output

### Package directory Info

|Dir|Contents|
|:-|:-|
|ca|contains the certificate authority|
|generated-certificates|certificates generated by GenerateCert|

