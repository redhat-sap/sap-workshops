# SAP E2E Automation
> Automating SAP HANA and S/4HANA by SAP end to end using Ansible and Ansible Tower

This workshop/demo can be used to demonstrate end to end automation for both HANA and S/4HANA using Ansible and Ansible Tower.

## High level architecture and components

The high level architecture consist on 4 different RHEL 8.x servers with the following purposes:

- bastion: this is meant to be used as the jump host for SSH access to the environment
- tower: this is meant to be used as the Ansible and Ansible Tower host where to run the automation from
- hana: this is meant to be used as the RHEL server where to deploy SAP HANA
- s4hana: this is meant to be used as the RHEL server where to deploy SAP S/4HANA

![e2e-infra-layout](img/infra_layout.png)

## Environment request

This enviroment is provioned using the Red Hat internal demo system. We at Red Hat embrace the use of [IaC](https://openpracticelibrary.com/practice/everything-as-code/) (Infrastructure as Code) for any lab/demo set up, that's why we have opensourced the Framework (based in Ansible) we use for this. If you want to get more information on this topic, check the [AgnosticD](https://github.com/redhat-cop/agnosticd) repository we use to deploy these labs and demos.

## How to run the demo/workshop

The goal for this demo is to showcase how we can make SAP Solutions deployments easy and reliable using Ansible automation. In order to be able to demonstrate this, a Tower Workflow has been configured that will do the following:

1. Enable all the required repositories in order to be able to deploy SAP software in RHEL
2. Configure all the File Systems and mount points required while installing SAP HANA and SAP S/4HANA
3. Install SAP Host Agent
4. Run all the OS pre-requisites from SAP Notes for RHEL systems while deploying SAP workloads
5. Run all the OS pre-requisites from SAP Notes for RHEL systems while deploying SAP HANA
6. Run all the OS pre-requisites from SAP Notes for RHEL systems while deploying SAP Netweaver software
7. Deploy SAP HANA
8. Deploy S/4HANA by SAP

Just by 'clicking a button' all these steps will be done automatically by Ansible Tower using a Tower Workflow. The final result will be a SAP landscape in RHEL with SAP HANA and SAP S/4HANA installed, configured and running.

![e2e-tower-full-workflow](img/tower-full-workflow.png)

The whole lab can be run as a quick demo, to show the end to end automation or as a workshop depending on the audience, the time and the level of detail you want to show from the lab.

### Running as a quick demo

When running as a quick demo, the first thing you need to do is login into the Ansible Tower web interface and launch the Workflow Template `SAP HANA and S/4HANA E2E deployment` that is already available. SAP HANA and SAP S/4HANA installation process will take a long time (the whole end to end process will take 40 minutes), so we you need to ensure the Tower Workflow is running in the background while you explain the key components of the set up.

![e2e-tower-workflow-gif](img/tower-workflow.gif)
<!-- ![e2e-tower-workflow-gif](video/tower-workflow.mp4) -->

<!-- <video width="700" height="400" controls preload> 
    <source src="video/tower-workflow.mp4"></source> 
</video> -->
<!-- 
![e2e-tower-workflow-gif](https://youtu.be/OTZbi4heRuM) -->

Once you show how the process is run with just 'one click' you can briefly explain all the required set up to be done in Ansible Tower. As explained before, Ansible Tower will run a collection of different playbooks in the HANA and S/4HANA RHEL hosts in order to prepare, deploy and configure the software. These are covered by point 1 to 8 as previusly mentioned. Ansible Tower needs to be configured the same way we configure a typical Ansible Host that is going to manage remote hosts. Ansible Tower allows the user to add this information from a Web Interface, which is very useful for people with no previuos experience with Ansible or people who don't feel confortable using a terminal. Ansible Tower also provides a very poweful REST API that can be used to confgure and performs multiple actions in Ansible Tower remotly from extarnal systems or applications.

For the quick demo, you can navigate through all the required configurations to be done in order to be able to set up and run the Tower Workflow from the demo.

#### Credentials

In order Tower to run Ansible Playbooks in remote hosts, the credentials required to access these hosts via SSH must be configured. On the left pane click on `Credentials`. This will show you all the actual credentials configured in Ansible Tower. One credential called `ssh-key` is already configured. This is a `Machine Type` credential that will contain the user information and SSH private key in order to be able to connect to the remote hosts via SSH.

![e2e-tower-workflow-credentials-gif](img/tower-workflow-credentials.gif)

#### Inventories

Ansible inventories are one of the key components required while automating IT. The inventory will contain the logical information of the hosts and all the required variables we need to use with the multiple Ansible Roles and Playbooks. On the left pane click on `Inventories`. This will show you all the actual inventories configured in Ansible Tower. An inventory called `sap-hosts` is already configured. This is the inventory we are using with all the Roles and Playbooks used by the Tower Job Templates.

To see more information about the inventory, click on the `sap-hosts` inventory and this will open another view where to see detailed information about the hosts, groups and variables configured. All the variables required have been configured already and these have been applied on the corresponding levels. Variables that are common to all the inventory hosts can be seen on the first screen when you click on the `sap-host` inventory. Once you are in the screen where this mentioned common variables appear (`sap_domain`, `sap_hostagent_installation_type`, etc...) you can click on the `HOSTS` button all the hosts configured under the inventory appear on the screen, `hana` and `s4hana` in this case.

![e2e-tower-workflow-inventories-gif](img/tower-workflow-inventories-01.gif)

You can now check the specific variables applied to the host clicking on each one and scrolling or expanding the variables field.

![e2e-tower-workflow-inventories-gif](img/tower-workflow-inventories-02.gif)