# vgs
VGS Data Tokenization API use cases

## Setup
Configure VGS account user ID and password credentials as environmental exports:
```python
export VGS_USERID={my_vgs_userid}
export VGS_PASSWORD={my_vgs_password}
```

## Optional Configuration
Scripts will default to use VGS alias format of "UUID" but can be changed to use other formats by setting this environment variable:
```python
export VGS_TOKEN_ALIAS_FORMAT={vg_alias_format}
```
Reference VGS different formats (and input value requirements/limitations) here: https://www.verygoodsecurity.com/docs/vault/concepts/tokens#alias-formats

## Usage (CLI)

```shell
./tokenize.sh value1:classifier1 [value2:classifier2 ...]
```

```shell
./detokenize.sh token1[,token2,...]
```


## API Schema

### Tokenize
```http
POST /aliases
{
  "data": [
    {
      "value": "$VALUE",
      "classifiers": [
        "$APP-DEFINED-LABEL"
      ],
      "format": "UUID",
      "storage": "PERSISTENT"
    }
  ]
}
```

### Detokenize



## API Examples

### Tokenize

```python
HTTP POST https://api.sandbox.verygoodvault.com/aliases
headers:
    'Content-Type: application/json'
```
```json
{
  "data": [
    {
      "value": "98761234019273877823782302238889920029",
      "classifiers": [
        "card_number"
      ],
      "format": "UUID"
    },
    {
      "value": "Joe Business",
      "classifiers": [
        "card_name"
      ],
      "format": "UUID"
    }
  ]
}
```

Response from API:
```json
{
  "data": [
    {
      "value": "98761234019273877823782302238889920029",
      "classifiers": [
        "card_number"
      ],
      "aliases": [
        {
          "alias": "tok_sandbox_eEhvAbg5dkgu2wuzqeCmq6",
          "format": "UUID"
        }
      ],
      "created_at": "2025-07-14T18:36:29Z",
      "storage": "PERSISTENT"
    },
    {
      "value": "Joe Business",
      "classifiers": [
        "card_name"
      ],
      "aliases": [
        {
          "alias": "tok_sandbox_k4FQhNkLDikwgfrYWrFqbu",
          "format": "UUID"
        }
      ],
      "created_at": "2025-07-14T18:31:20Z",
      "storage": "PERSISTENT"
    }
  ]
}
```

### Detokenize

```python
GET ./detokenize.sh tok_sandbox_eEhvAbg5dkgu2wuzqeCmq6,tok_sandbox_k4FQhNkLDikwgfrYWrFqbu
headers:
    'Content-Type: application/json'
```

Response from API:
```json
{
  "data": {
    "tok_sandbox_k4FQhNkLDikwgfrYWrFqbu": {
      "value": "Joe Business",
      "classifiers": [
        "card_name"
      ],
      "aliases": [
        {
          "alias": "tok_sandbox_k4FQhNkLDikwgfrYWrFqbu",
          "format": "UUID"
        },
        {
          "alias": "vgssbx00evBzAZvJrraZtOICflbCT",
          "format": "VGS_FIXED_LEN_GENERIC"
        }
      ],
      "created_at": "2025-07-14T18:31:20Z",
      "storage": "PERSISTENT"
    },
    "tok_sandbox_eEhvAbg5dkgu2wuzqeCmq6": {
      "value": "98761234019273877823782302238889920029",
      "classifiers": [
        "card_number"
      ],
      "aliases": [
        {
          "alias": "987612mj2rvB03V0029",
          "format": "ALPHANUMERIC_SIX_T_FOUR"
        },
        {
          "alias": "vgssbx00Wxk6tfLfWPKnh45rADIV3",
          "format": "VGS_FIXED_LEN_GENERIC"
        },
        {
          "alias": "tok_sandbox_eEhvAbg5dkgu2wuzqeCmq6",
          "format": "UUID"
        }
      ],
      "created_at": "2025-07-14T18:36:29Z",
      "storage": "PERSISTENT"
    }
  }
}
```



## API Routes & Proxies
Besides the usual direct API interaction your application can have with tokenization API use cases, VGS also supports enabling transactional proxies (intermediaries) that can handle securing PCI or sensitive information during transactions with 3rd party providers (e.g. PSPs).

VGS proxies route data for various data transmission protocols, including HTTPS, SFTP, FTPS, and SMTP. VGS Routes are payload-agnostic and can transform any binary or text-based payload, including JSON, XML, HTML, PDFs, and compressed files.

They also support proxying device communications built on ISO8583 POS/ATM messaging standards and support proxying 3270 Mainframe and other telnet based protocols.
