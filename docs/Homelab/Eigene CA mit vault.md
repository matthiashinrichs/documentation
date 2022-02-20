# Create CA

```
vault secrets enable -path=homenet_ca pki

vault secrets tune -max-lease-ttl=87600h homenet_ca

vault write -field=certificate homenet_ca/root/generate/internal \
     common_name="homenet" \
     organization="hnrx" \
     organizational_unit="Development" \
     locality="Baar" \
     province="ZG" \
     country="CH" \
     postal_code="6340" \
     ttl=87600h > CA_cert.crt

vault write homenet_ca/config/urls \
     issuing_certificates="$VAULT_ADDR/v1/homenet_ca/ca" \
     crl_distribution_points="$VAULT_ADDR/v1/homenet_ca/crl"
```

# Generate intermediate CA

```
vault secrets enable -path=homenet_int pki

vault secrets tune -max-lease-ttl=43800h homenet_int

vault write -format=json homenet_int/intermediate/generate/internal \
     common_name="homenet Intermediate Authority" \
     | jq -r '.data.csr' > homenet_intermediate.csr

vault write -format=json homenet_ca/root/sign-intermediate csr=@homenet_intermediate.csr \
     format=pem_bundle ttl="43800h" \
     | jq -r '.data.certificate' > intermediate.cert.pem

vault write homenet_int/intermediate/set-signed certificate=@intermediate.cert.pem
```

# Create a role

```
vault write homenet_int/roles/homenet \
     allowed_domains="homenet" \
     allow_subdomains=true \
     max_ttl="732d"
```

# Request certificates

```
vault write homenet_int/issue/homenet common_name="test.homenet" ttl="24h"
```


vault write homenet_int/tidy tidy_cert_store=true tidy_revoked_certs=true