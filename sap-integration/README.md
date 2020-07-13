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

[![smart-infra-layout](img/infra_layout.png)](https://redhat-sap.github.io/sap-workshops/sap-smart-management/img/infra_layout.png)

## Use cases

This workshop will cover the following use cases:

- RestAPI app exposing flight data bapis, import into FuseOnline later. Mobile app using those APIs, or simple HTML page. Create and integration data flow.
- OpenAPI documents imported from SAP Business Hub into 3Scale, so we can demo 3Scale functionallity.
- OData endpoints from SAP HANA or SAP Gateway (OData Server on top of bapis) and import into Fuse Online. Create and integration data flow.

## Environment request

This environment is provisioned using the Red Hat internal demo system. We at Red Hat embrace the use of [IaC](https://openpracticelibrary.com/practice/everything-as-code/) (Infrastructure as Code) for any lab/demo set up, that's why we have open-sourced the Framework (based in Ansible) we use for this. If you want to get more information on this topic, check the [AgnosticD](https://github.com/redhat-cop/agnosticd) repository we use to deploy these labs and demos.

### Order catalog item

Login into [Red Hat Product Demo System](https://rhpds.redhat.com) and navigate to `Services --> Catalogs --> All Services --> Workshops`. An item called `SAP side-by-side Integration` will be available.

[![rhpds-catalog](img/rhpds01.png)](https://redhat-sap.github.io/sap-workshops/sap-smart-management/img/rhpds01.png)

Click on the **order** button, check the confirmation box and click on **Submit**.

[![rhpds-submit](img/rhpds02.png)](https://redhat-sap.github.io/sap-workshops/sap-smart-management/img/rhpds02.png)

## Environment info and credentials

Once the environment has been provisioned, you will receive an email with some key information:

- SSH information to access the bastion host including:
  - SSH user information
  - Bastion public hostname information
  - SSH private key to be used
- OpenShift information including:
  - OpenShift web-console public URL
  - OpenShift web-console user
  - OpenShift web-console password
- 3Scale information including:
  - 3Scale namespace in OpenShift
  - 3Scale API Management Portal user
  - 3Scale API Management Portal password
- Fuse Online information including:
  - Fuse Online namespace in OpenShift

## How to run the workshop

## Use Case 2: Using 3Scale to manage APIs from SAP's Bussines Hub

This scenario will show how to configure 3Scale to centralize API management from SAP Bussines Hub and enrich those APIs with all the capabilities 3Scale can offer. To demonstrate this, we are going to use the [Analytical reporting APIs from SAP Ariba](https://api.sap.com/api/analytics_reporting_view/overview).

A user in https://api.sap.com is required to complete this configuration. A free account can be created, using the `Log On` button on the top right and using the `Register` option when prompted for your login details.

[![300-left](img/sap_api_register.png)](https://redhat-sap.github.io/sap-workshops/sap-integration/img/sap_api_register.png)
