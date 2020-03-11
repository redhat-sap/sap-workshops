# SAP E2E Automation
> Automating SAP HANA and S/4HANA by SAP end to end using Ansible and Ansible Tower

This workshop/demo can be used to demonstrate end to end automation for both HANA and S/4HANA using Ansible and Ansible Tower.

## High level architecture and components

The high level architecture consist on 4 different RHEL 8.x servers with the following purposes:

- bastion: this is meant to be used as the jump host for SSH access to the environment
- tower: this is meant to be used as the Ansible and Ansible Tower host where to run the automation from
- hana: this is meant to be used as the RHEL server where to deploy SAP HANA
- s4hana: this is meant to be used as the RHEL server where to deploy S/4HANA by SAP

![e2e-infra-layout](img/infra_layout.png)

## Environment request

This enviroment is provioned using the Red Hat internal demo system. We at Red Hat embrace the use of IaC for any lab/demo set up, that's why we have opensourced the Framework (based in Ansible) we use for this. If you want to get more information on this topic, check the [AgnosticD](https://github.com/redhat-cop/agnosticd) repository we use to deploy these labs and demos.

## How to run the demo/workshop

The goal for this demo is to showcase how we can make SAP Solutions deployments easy and reliable using Ansible automation. In order to be able to demonstrate this, a Tower Workflow has been configured that will do the following:

1- Enable all the required repositories in order to be able to deploy SAP software in RHEL
2- Configure all the File Systems and mount points required while installing SAP HANA and S/4HANA by SAP
3- Install SAP Host Agent
4- Run all the OS pre-requisites from SAP Notes for RHEL systems while deploying SAP workloads
5- Run all the OS pre-requisites from SAP Notes for RHEL systems while deploying SAP HANA
6- Run all the OS pre-requisites from SAP Notes for RHEL systems while deploying SAP Netweaver software
7- Deploy SAP HANA
8- Deploy S/4HANA by SAP

Just by 'clicking a button' all these steps will be done automatically by Ansible Tower using a Tower Workflow. The final result will be a SAP landscape in RHEL with SAP HANA and S/4HANA installed, configured and running.

![e2e-tower-full-workflow](img/tower-full-workflow.png)