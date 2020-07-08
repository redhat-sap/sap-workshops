# SAP side by side Integration (**WORK IN PROGRESS**)
> Using Red Hat Integration Portfolio and Red Hat Openshift to integrate with SAP side by side

## Intro

This workshop can be used to demonstrate the integration capabilities for Red Hat Integration portfolio with SAP's Digital Core. 

## High-level architecture and components

The high-level architecture consists of 3 different RHEL 8.x servers:

- **bastion**: this is meant to be used as the jump host for SSH access to the environment and where to run SAP GUI from if required
- **hana**: this is meant to be used as the RHEL server where to deploy SAP HANA
- **s4hana**: this is meant to be used as the RHEL server where to deploy SAP S/4HANA
  
And an OpenShift 4.x cluster with the following components deployed:

- **OpenShift Container Storage**: used for multi purpose container storage backend
- **Fuse Online**: used for
- **3Scale**: used for


## Use cases

This workshop will cover the following use cases:

- RestAPI app exposing flight data bapis, import into FuseOnline later. Mobile app using those APIs, or simple HTML page. Create and integration data flow.
- OpenAPI documents imported from SAP Business Hub into 3Scale, so we can demo 3Scale functionallity.
- OData endpoints from SAP HANA or SAP Gateway (OData Server on top of bapis) and import into Fuse Online. Create and integration data flow.


[![smart-infra-layout](img/infra_layout.png)](https://redhat-sap.github.io/sap-workshops/sap-smart-management/img/infra_layout.png)