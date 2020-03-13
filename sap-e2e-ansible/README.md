# SAP E2E Automation
> Automating SAP HANA and S/4HANA by SAP end to end using Ansible and Ansible Tower

## Intro

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

#### Projects

Ansible Tower projects are logical collection of Ansible playbooks. Using Tower projects you can manage playbooks and playbook directories by either placing them manually under the Project Base Path on your Tower server, or by placing your playbooks into a source code management (SCM) system supported by Tower. The last is the approach used here, where projects will pull the information from GitHub.

All the projects are pointing to the same [GitHub Repository](https://github.com/redhat-sap/sap-tower-projects). This is a multi-branch repository where each branch is keeping different playbooks using different Ansible Roles.

When configuring SCM based Tower projects, this information (git url and branch) we have provided is used to pull the information from each branch.

On the left pane click on `Projects`. This will show you all the Tower projects configured. There is an equivalency between the number of projects configured and the Ansible Roles used. Basically each project will provide a Playbook from the mentioned GitHub repository, and this Playbook will use a Role to run each step of the Tower Workflow.

![e2e-tower-workflow-projects-gif](img/tower-workflow-projects.gif)

#### Job Templates

Tower job templates are definitions and set of parameters for running Ansible jobs. In other words, it will use Playbooks from Tower projects explained on the previuos step with hosts from a selected inventories.

On the left pane click on `Templates`. This will show you all the Tower job templates configured. As previously explained, there was an equivalency between the number of projects and Ansible Roles used here. If you click on any of the configured job templates, you can see that every job template is using the Playbook `play.yml` from a different project, which points to a diffrent branch on the GitHub repository previously explained. That playbook will use an specific Ansible Role (Red Hat Supported System Roles and Community Roles from Red Hat's SAP CoP) to perform the required actions to get the hosts from the inventory to the desired state.

![e2e-tower-workflow-templates-gif](img/tower-workflow-templates-01.gif)

As an example, let's review the whole flow:

- `sap-hostagent` job template is using `play.yml` Playbook from `sap-hostagent` project which includes the `redhat_sap.sap_hostagent` Role as part of the Playbook
- `sap-hostagent` project is using `https://github.com/redhat-sap/sap-tower-projects.git` repository specifically on the `sap-hostagent` branch
- `sap-hostagent` branch from that repository contains the playbook `play.yml` previosly mentioned and a `roles` directory containing a `requirements.yml` file
- `requirements.yml` file contains the reference to `redhat_sap.sap_hostagent` Ansible Galaxy Role
- Ansible Tower will automatically pull that Role dring the job template execution, so this can be used by the `play.yml` Playbook

#### Workflow Templates

Tower Workflow job templates link together a sequence of disparate resources that accomplishes the task of tracking the full set of jobs that were part of the release process as a single unit. It basically allows you to create pipeline-like strategies to automate your IT landscape.

Same as Tower job templates, you can access workflow templates by clicking `Templates` on the left pane link. It is easy to differentiate a `Tower Job Template` from a `Tower Workflow Template`. On a first view, you can already see the tag that Tower adds close to the template name, and these can be `Job Template` and `Workflow Template`. Also you will see an extra icon for the workflow templates, like a hierarchy chart. This icon represents the visualizer link for the workflow.

![e2e-tower-workflow-templates-gif](img/tower-workflow-templates-02.gif)

As you can see from the animated image, once you click on the workflow visualizer you will get an overview of the existing workflow steps representing all the stages in our automation pipeline. This workflow visualizer can be used as well t modify the existing flow, adding and removing steps or change the logical order and actions happening before and after every step.

#### Showing results

As the final step for this quick demo, we will show the results from the workflow execution we did when we started the demo. Remember that the workflow has been executed in the background while we were showing all the components and by this time it should be completed.

The first thing to show is the workflow results itself. To do that, on the left pane click on `Jobs`, this will show all the Tower jobs that has been executed or are still running. Find the last `Workflow Job` that has been executed, it is called `SAP HANA and S/4HANA E2E deployment` preceded by a number that is used to identify the job id. If you click on this job, it will take you to the job details information, where you can see the status, when it did start and when it did finish. The whole pipeline to prepare the hosts, deploy and configure HANA and S/4HANA should took 30-40 minutes. If you check the right pane from that window you will see the workflow visualizer with all the nodes (steps in the pipeline) in green, representing that correct execution of the whole workflow.

![e2e-tower-workflow-review-gif](img/tower-workflow-review-01.gif)

Now we can login into the `hana` and `s4hana` hosts to validate this is true. Using the logon instructions email you received, login into the `hana` hosts first and execute the following to check all the SAP HANA processes are running in the system:

```bash
hana:rheadm> HDB info
USER          PID     PPID  %CPU        VSZ        RSS COMMAND
rheadm     140412   140411   0.0     234172       5104 -sh
rheadm     141604   140412   0.0     222712       3332  \_ /bin/sh /usr/sap/RHE/HDB00/HDB info
rheadm     141635   141604   0.0     266920       3932      \_ ps fx -U rheadm -o user:8,pid:8,ppid:8,pcpu:5,vsz:10,rss:10,args
rheadm      34937        1   0.0    4015240      47984 hdbrsutil  --start --port 30003 --volume 3 --volumesuffix mnt00001/hdb00003.00003 --identifier 15840414
rheadm      28661        1   0.0     672908      15932 hdbrsutil  --start --port 30001 --volume 1 --volumesuffix mnt00001/hdb00001 --identifier 1584039495
rheadm      28507        1   0.0      24964       1336 sapstart pf=/hana/shared/RHE/profile/RHE_HDB00_hana
rheadm      28515    28507   0.0     425712      33416  \_ /usr/sap/RHE/HDB00/hana/trace/hdb.sapRHE_HDB00 -d -nw -f /usr/sap/RHE/HDB00/hana/daemon.ini pf=/usr
rheadm      28533    28515   6.8    6692276    3433656      \_ hdbnameserver
rheadm      28869    28515   0.3     674884      93748      \_ hdbcompileserver
rheadm      28872    28515   4.5     724868     151048      \_ hdbpreprocessor
rheadm      29276    28515   0.3    1921836     201392      \_ hdbwebdispatcher
rheadm      33961    28515  51.6   49781808   46822336      \_ hdbindexserver -port 30003
rheadm      34037    28515   0.8    3203024    1155388      \_ hdbxsengine -port 30007
rheadm      34040    28515   0.8    4671316    2417044      \_ hdbdocstore -port 30040
rheadm      34043    28515   0.8    3107012    1157632      \_ hdbdpserver -port 30011
rheadm      35423    28515   0.3    1692816     328896      \_ hdbdiserver -port 30025
rheadm      28433        1   0.0     520996      23900 /usr/sap/RHE/HDB00/exe/sapstartsrv pf=/hana/shared/RHE/profile/RHE_HDB00_hana -D -u rheadm
```

Once we have validated SAP HANA is installed and running, login into the `s4hana` hosts first and execute the following to check all SAP S/4HANA processes are running in the system:

```bash
$ ps auxwwf | grep rheadm | grep -v grep
rheadm   32386  0.0  0.2 893884 91780 ?        Ssl  Mar12   0:09 /usr/sap/RHE/ASCS01/exe/sapstartsrv pf=/usr/sap/RHE/SYS/profile/RHE_ASCS01_s4hana -D -u rheadm
rheadm     496  0.0  0.0  62624  3964 ?        Ss   Mar12   0:00 sapstart pf=/usr/sap/RHE/SYS/profile/RHE_ASCS01_s4hana
rheadm     509  0.0  0.0 100016 22248 ?        Ssl  Mar12   0:00  \_ ms.sapRHE_ASCS01 pf=/usr/sap/RHE/SYS/profile/RHE_ASCS01_s4hana
rheadm     510  0.0  2.2 2266592 749396 ?      Ssl  Mar12   0:09  \_ enq.sapRHE_ASCS01 pf=/usr/sap/RHE/SYS/profile/RHE_ASCS01_s4hana
rheadm    2143  0.0  0.1 903668 47508 ?        Ssl  Mar12   0:05 /usr/sap/RHE/D00/exe/sapstartsrv pf=/usr/sap/RHE/SYS/profile/RHE_D00_s4hana -D -u rheadm
rheadm    6637  0.0  0.0  62768  4208 ?        Ss   Mar12   0:00 sapstart pf=/usr/sap/RHE/SYS/profile/RHE_D00_s4hana
rheadm    6652  0.0  0.5 32335464 178100 ?     Ssl  Mar12   0:10  \_ dw.sapRHE_D00 pf=/usr/sap/RHE/SYS/profile/RHE_D00_s4hana
rheadm    6657  0.0  0.1 663840 34116 ?        S    Mar12   0:02  |   \_ gwrd -dp pf=/usr/sap/RHE/SYS/profile/RHE_D00_s4hana
rheadm    6658  0.0  0.4 1833160 146000 ?      Sl   Mar12   0:02  |   \_ icman -attach pf=/usr/sap/RHE/SYS/profile/RHE_D00_s4hana
rheadm    6659  0.0  4.9 32392208 1623068 ?    S    Mar12   0:22  |   \_ dw.sapRHE_D00 pf=/usr/sap/RHE/SYS/profile/RHE_D00_s4hana
rheadm    6660  0.0  1.6 32384420 551340 ?     S    Mar12   0:07  |   \_ dw.sapRHE_D00 pf=/usr/sap/RHE/SYS/profile/RHE_D00_s4hana
rheadm    6661  0.0  2.5 32401640 830196 ?     S    Mar12   0:27  |   \_ dw.sapRHE_D00 pf=/usr/sap/RHE/SYS/profile/RHE_D00_s4hana
rheadm    6662  0.0  2.2 32385604 746780 ?     S    Mar12   0:26  |   \_ dw.sapRHE_D00 pf=/usr/sap/RHE/SYS/profile/RHE_D00_s4hana
rheadm    6663  0.0  1.8 32385988 605064 ?     S    Mar12   0:13  |   \_ dw.sapRHE_D00 pf=/usr/sap/RHE/SYS/profile/RHE_D00_s4hana
rheadm    6664  0.0  1.8 32383096 619660 ?     S    Mar12   0:11  |   \_ dw.sapRHE_D00 pf=/usr/sap/RHE/SYS/profile/RHE_D00_s4hana
rheadm    6665  0.0  2.0 32383956 663848 ?     S    Mar12   0:13  |   \_ dw.sapRHE_D00 pf=/usr/sap/RHE/SYS/profile/RHE_D00_s4hana
rheadm    6666  0.0  1.8 32379024 593920 ?     S    Mar12   0:13  |   \_ dw.sapRHE_D00 pf=/usr/sap/RHE/SYS/profile/RHE_D00_s4hana
rheadm    6667  0.0  1.8 32385948 592028 ?     S    Mar12   0:18  |   \_ dw.sapRHE_D00 pf=/usr/sap/RHE/SYS/profile/RHE_D00_s4hana
rheadm    6668  0.0  2.0 32387128 674740 ?     S    Mar12   0:17  |   \_ dw.sapRHE_D00 pf=/usr/sap/RHE/SYS/profile/RHE_D00_s4hana
rheadm    6669  0.0  0.3 32354428 103696 ?     S    Mar12   0:02  |   \_ dw.sapRHE_D00 pf=/usr/sap/RHE/SYS/profile/RHE_D00_s4hana
rheadm    6670  0.0  1.3 32524396 435252 ?     S    Mar12   0:20  |   \_ dw.sapRHE_D00 pf=/usr/sap/RHE/SYS/profile/RHE_D00_s4hana
rheadm    6671  0.0  2.1 32501108 697152 ?     S    Mar12   0:20  |   \_ dw.sapRHE_D00 pf=/usr/sap/RHE/SYS/profile/RHE_D00_s4hana
rheadm    6672  0.0  1.1 32467288 376772 ?     S    Mar12   0:19  |   \_ dw.sapRHE_D00 pf=/usr/sap/RHE/SYS/profile/RHE_D00_s4hana
rheadm    6673  0.0  1.8 32444420 621832 ?     S    Mar12   0:12  |   \_ dw.sapRHE_D00 pf=/usr/sap/RHE/SYS/profile/RHE_D00_s4hana
rheadm    6674  0.0  1.5 32527136 504376 ?     S    Mar12   0:30  |   \_ dw.sapRHE_D00 pf=/usr/sap/RHE/SYS/profile/RHE_D00_s4hana
rheadm    6675  0.0  1.2 32532704 413528 ?     S    Mar12   0:20  |   \_ dw.sapRHE_D00 pf=/usr/sap/RHE/SYS/profile/RHE_D00_s4hana
rheadm    6676  0.0  0.3 32357480 125284 ?     S    Mar12   0:04  |   \_ dw.sapRHE_D00 pf=/usr/sap/RHE/SYS/profile/RHE_D00_s4hana
rheadm    6677  0.0  0.3 32354428 104068 ?     S    Mar12   0:02  |   \_ dw.sapRHE_D00 pf=/usr/sap/RHE/SYS/profile/RHE_D00_s4hana
rheadm    6653  0.0  0.0  63720  9416 ?        Ss   Mar12   0:00  \_ ig.sapRHE_D00 -mode=profile pf=/usr/sap/RHE/SYS/profile/RHE_D00_s4hana
rheadm    6654  0.0  0.0 1288252 28256 ?       Sl   Mar12   0:10      \_ /usr/sap/RHE/D00/exe/igsmux_mt -mode=profile -restartcount=0 -wdpid=6653 pf=/usr/sap/RHE/SYS/profile/RHE_D00_s4hana
rheadm    6655  0.0  0.2 1150676 80808 ?       Sl   Mar12   0:06      \_ /usr/sap/RHE/D00/exe/igspw_mt -mode=profile -no=0 -restartcount=0 -wdpid=6653 pf=/usr/sap/RHE/SYS/profile/RHE_D00_s4hana
rheadm    6656  0.0  0.2 1150680 81356 ?       Sl   Mar12   0:06      \_ /usr/sap/RHE/D00/exe/igspw_mt -mode=profile -no=1 -restartcount=0 -wdpid=6653 pf=/usr/sap/RHE/SYS/profile/RHE_D00_s4hana
```

We should see all the `sapstart` processes running along `dw` processes that will handle user requests.

We have demonstrated that we can use Ansible to automate SAP HANA and SAP S/4HANA deployments end to end **with just one click!!**