# Ansible generator

### Please note this work is continued in:
### https://github.com/fortinet-ansible-dev/fortios-ansible-generator
### https://github.com/fortinet-ansible-dev/fortimanager-ansible-generator


Ansible Generator is an internal tool that is used to help in the process of generating Ansible modules for FortiGate appliances.

It has to be fed with a Json Schema of the FortiGate whose modules are to be generated.


## Usage

Get a FortiOS schema in json format (REST GET http://<fgt_ip>/api/v2/cmdb?action=schema) and copy it to the root folder of this repo.

Name it: fgt_schema.json

Run:

`./generate.py`

Check the output in ansible_generator/output/vX.X.X


## Notes


#### Avoid hyphens in attributes

<b>May 2019</b>

Due to Ansible requirements no hyphens are allowed in attribute names and all modules have been updated to comply with this. 

FortiGate attributes make extensive use of hyphens in attribute names, thus this generator now converts automatically Ansible attribute names (with underscores) to FortiGate attribute names (with hyphens).

This is transparent to the user but old playbooks need to be adapted:

  E.g.: "notify-hosts" will now be "notify_hosts"

#### Move 'state' attribute

According to Ansible requirements, the 'state' attribute used to indicate 'present' or 'absent' has been moved one level up and is now part of the module attributes.
