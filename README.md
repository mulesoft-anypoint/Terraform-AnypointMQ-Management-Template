# Terraform Template Anypoit MQ

This repository aims to provide a basic terraform template to create and manage your Anypoint MQ components:

* Queues
* Exchanges
* Binding rules

## Install

Run the following command to initialize terraform:

```bash
terraform init
```

## How to use

The template comes with a set of variables that allows you to:

* Authenticating using a connected app or an access token
* Define the Anypoint Platform Control plane to use
* Define where your input files location
* Set defautl values for the different components

The script expects 4 files as input. Each file represents a set of specfic type of Anypont MQ component:

* **queues.json**: defines a list of queues to be created
* **dlq.json**: defines a list of dead letter queues to be created
* **exchanges.json**: defines a list of exchanges to be created
* **bindings.json**: defines the list of bindings between exchanges and queues along with their rules

### Queues file: queues.json

This file is used to create queues only, it should contain a list of elements with the following format:

```json
[
  {
    "name": "AMQ02",
    "environments": [
      "Sandbox",
      "Design"
    ],
    "region": "us-west-2",          //optional, if not present var.region is used
    "default_ttl": 65123131,        //optional, if not present var.q_default_ttl is used
    "default_lock_ttl": 123,        //optional, if not present var.q_default_lock_ttl is used
    "default_delivery_delay": 0,    //optional, if not present var.q_default_delivery_delay is used
    "fifo": true,                   //optional, if not present var.q_fifo is used
    "encrypted": true,              //optional, if not present var.q_encrypted is used
    "dlq": "DLQ01",                 //optional
    "max_deliveries": 10,           //optional, can only be used if dlq is used
  }
]
```

### DLQ file: dlq.json

This file is used to create dead letter queues only. The format should be as follow:

```json
[
  {
    "name": "DLQ01",
    "environments": [
      "Sandbox",
      "Design"
    ],
    "region": "us-west-2",    //optional, if not present var.region is used
    "fifo": true,             //optional, if not present var.dlq_fifo is used
    "encrypted": true         //optional, if not present var.dlq_encrypted is used
  }
]
```

### Exchanges file: exchanges.json

This file is used to create exchanges only. The format is as follows:

```json
[
  {
    "name": "MyExchange",
    "environments": [
      "Sandbox"
    ],
    "region": "us-west-2",    //optional, if not present var.region is used
    "encrypted": true         //optional, if not present var.ex_encrypted is used
  }
]
```

### Binding file: bindings.json

This file is used to create bindings only. The format is as follows:

```json
[
  {
    "exchange": "MyExchange",
    "queue": "Q01",
    "environments": [
      "Sandbox"
    ],
    "region": "us-west-2",              //optional, if not present var.region is used
    "rule": {     //optional
      "name": "rule_num_compare",       //required, should use specific rules check below for more info
      "property_name": "nbr_horses",
      "property_type": "NUMERIC",
      "matcher_type": "GT",
      "value": 12
    }
  }
]
```

The rule object is optional, be when provided, all properties are required should be as follow:

* **name**: the name of the value to use, there is a predefined set of rules that you should select from:
  * *rule_num_compare*: compares **NUMERIC** types to **NUMERIC** values only. [More info](https://registry.terraform.io/providers/mulesoft-anypoint/anypoint/latest/docs/resources/ame_binding#nested-schema-for-rule_num_compare).
  * *rule_num_set*: compares **NUMERIC** types to a set of **NUMERIC** values. [More info](https://registry.terraform.io/providers/mulesoft-anypoint/anypoint/latest/docs/resources/ame_binding#nested-schema-for-rule_num_set).
  * *rule_num_state*: compares **NUMERIC** types existance. [More info](https://registry.terraform.io/providers/mulesoft-anypoint/anypoint/latest/docs/resources/ame_binding#nested-schema-for-rule_num_state).
  * *rule_str_compare*: compares **STRING** types to **STRING** values only. [More info](https://registry.terraform.io/providers/mulesoft-anypoint/anypoint/latest/docs/resources/ame_binding#nested-schema-for-rule_str_compare).
  * *rule_str_set*: compares **STRING** type to a set of **STRING** values. [More info](https://registry.terraform.io/providers/mulesoft-anypoint/anypoint/latest/docs/resources/ame_binding#nested-schema-for-rule_str_set).
  * *rule_str_state*: compares **STRING** existance. [More info](https://registry.terraform.io/providers/mulesoft-anypoint/anypoint/latest/docs/resources/ame_binding#nested-schema-for-rule_str_state).
* **property_name**: the property name subject of the rule
* **property_type**: can either be **NUEMRIC** or **STRING** depending on the type of the rule.
* **matcher_type**: the operation to perform on the property. More info on each type of rule to see available options.
* **value**: The value against which the operation will be performed.

## Variables Reference

Following is the list of available variables

| Title              | Description                       | Example         |
|--------------------|-----------------------------------|-----------------|
