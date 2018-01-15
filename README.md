Ansible Role YUM
=========

[![Build Status](https://travis-ci.org/Turgon37/ansible-yum.svg?branch=master)](https://travis-ci.org/Turgon37/ansible-yum)

:warning: This role is under development, some important (and possibly breaking) changes may happend. Don't use it in production level environments but you can eventually base your own role on this one :hammer:

:grey_exclamation: Before using this role, please know that all my Ansible roles are fully written and accustomed to my IT infrastructure. So, even if they are as generic as possible they will not necessarily fill your needs, I advice you to carrefully analyse what they do and evaluate their capability to be installed securely on your servers.

**This roles configure YUM common settings, some yum plugins**

## Features

Currently this role provide the following features :

  * yum-cron settings for daily and hourly packages updates checks
  * yum plugins settings:
    * post-transactions-actions
  * monitoring items for
    * Zabbix
  * [local facts](#facts)

## Requirements

### OS Family

This role is available for RedHat/CentOS

### Dependencies

This role use a dependency to itself on the name 'yum' to deploy custom post transactions actions. Please be sure that it is correctly named in requirements.yml.

If you use the zabbix monitoring profile you will need the role [ansible-zabbix-common](https://github.com/Turgon37/ansible-zabbix-common)

## Role Variables

The variables that can be passed to this role and a brief description about them are as follows:

| Name              | Types/Values | Description                       |
| ------------------| -------------|---------------------------------- |

## Role Types

This role provide the following pseudo-type

### A post transaction actions rule

You can create custom post yum transaction actions from any other role by using the include role statement

```
- include_role:
    name: yum
    tasks_from: post-transaction-action
  vars:
    yum__post_transaction_action:
      name: 01kernel_grub_check
      matches:
        - action_key: package_name
          transaction_state: any
          command: '{{ yum__custom_scripts_directory }}/custom_scripts.sh'
      state: present
```


## Example Playbook

To use this role create or update your playbook according the following example :


```
    - hosts: servers
      roles:
        - yum
      vars:
        yum__cron_settings_global:
          email_to: 'admin@example.com'
```


## License

MIT