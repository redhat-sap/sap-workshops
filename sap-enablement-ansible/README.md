Overview
========

Base Requirements to access and perform this lab
------------------------------------------------

-   A computer with access to Internet :-)

-   SSH client (for Microsoft Windows users
    [Putty](https://www.putty.org/) and
    [WinSCP](https://winscp.net/eng/downloads.php) or
    [MobaXterm](https://mobaxterm.mobatek.net/download.html) is
    recommended)

-   Firefox 17 or higher, or Chromium / Chrome

High-level architecture and components
--------------------------------------

The high-level architecture consists of 4 different RHEL 8.x servers
with the following purposes:

-   bastion: this is meant to be used as the jump host for SSH access to
    the environment

-   tower: this is meant to be used as the Ansible and Ansible Tower
    host where to run the automation from

-   hana1, hana2: this is meant to be used as the RHEL server where to
    deploy SAP HANA

-   s4hana: this is meant to be used as the RHEL server where to deploy
    SAP S/4HANA

![e2e-infra-layout](img/infra_layout.png)

Environment request
-------------------

This environment is provisioned using the Red Hat internal demo system.
We at Red Hat embrace the use of
[IaC](https://openpracticelibrary.com/practice/everything-as-code/)
(Infrastructure as Code) for any lab/demo set up, that’s why we have
open-sourced the Framework (based in Ansible) we use for this. If you
want to get more information on this topic, check the
[AgnosticD](https://github.com/redhat-cop/agnosticd) repository we use
to deploy these labs and demos.

If you are a Red Hat Advanced or Premium Partner, you can immediately
deploy this environment yourself, following the next steps. If you are
participant in a workshop, this lab may be preprovisioned for you and
you can continue with the next chapter "Prepare Access to Lab
Environment". The information to access the environment will be given to
you during the workshop.

### Order catalog item

Login into [Red Hat Product Demo System](https://rhpds.redhat.com) and
navigate to
`Services -→ Catalogs -→ All Services -→ RHEL Platform Demo`. An item
called `SAP End to End Automation AWS` will be available.

![rhpds-catalog](img/rhpds01.png)

Click on the **order** button, check the confirmation box and click on
**Submit**.

![rhpds-submit](img/rhpds02.png)

### Environment info and credentials

Once the environment has been provisioned, you will receive an email
with some key information:

-   SSH information to access the bastion host including:

    -   SSH user information

    -   Bastion public hostbane information

    -   SSH private key to be used

-   Ansible Tower information including:

    -   Ansible Tower public URL

    -   Ansible Tower user

    -   Ansible Tower Password

### Working the Labs

You might have guessed by now this lab is pretty commandline-centric…​
:-)

-   Don’t type everything manually, use copy & paste from the browser
    when appropriate. But don’t stop to think and understand…​ ;-)

-   All labs where prepared using vi, but feel free to use your
    favoutite editor.

> **Tip**
>
> In the lab guide commands you are supposed to run are shown with or
> without the expected output, whatever makes more sense in the context.

> **Tip**
>
> The command line can wrap on the web page from time to time. Therefor
> the output is separated from the command line for better readability
> by an empty line. **Anyway, the line you should actually run should be
> recognizable by the prompt.** :-)

Prepare Access to Lab environment
=================================

Before you provision your lab environment you want to make sure that you
can connect to your servers after the provisioning. This can be achieved
via ssh public-keys.

Setup SSH on Linux and macOS
----------------------------

To access the jumphost via SSH, open a terminal, locate the provided
private SSH key, and store it in e.g.`~/.ssh/mylabkey` and change the
rights to user read-only:

    $ chmod 600 ~/.ssh/mylabkey

> **Note**
>
> You need to copy all the lines incl. the header and footer line, so
> that the content looks like this:

\+

    $ cat ~/.ssh/mylabkey
    -----BEGIN RSA PRIVATE KEY-----
    Ofu9VdWCBNm4XJiruBFpZMyz1fY8hs28u3xKQeFf utVjbXS6SH1eYve34IDtm4Z
    WYUVFVLU30mLnEZ8laZTYFS53gMO6CAhvKFt7h2DH16OwZ9e155kKuHYnri5J28O
    lkpW2mf4fHiAXY2ORmKBa2xMFjqZs9hCvtEMA5s939IILC9oEAQkvO15WOLMvEYu
    FuoMu0gaS3NhkILLvgt3tJToHz2Mzv4GYlNSOy6bsojM0ZqtHPByIPpF0NFEgMx5
    8JvdwoETVMOoJack43Db6OulOWWA3k0bnTsNEDrvDR8a0O8p9KtjvJwteSleoCgX
    C6Hrh62mtxQtXrqLNYA1ZZIbKYHim3K5CkEmAMrsO0qHwDRe5iGo8bAC8hrVe8Cx
    Cgr0Dktx7lfoZ8d6tV5ViSzaqQk1SrAKk0LRiiTbyimzsaJouLF4a1TcVsp3k4g2
    HFmONZNdR1XvQBmap62bJBErGAZru5bQmi755q8wwAJkyW6clZ4RSO8lDnksKlYw
    4ikQ1OkPndE5SId0bQ1g3szdOoB42LwlY7RilIap5P54TTbPim0oeEL1kbFlLhE2
    tFP0mGsVKA49AwXFH585HgopQZAd4J331Gh0yetNVKvljzmfKyjNYlda5jPgpNRA
    JObXb4CEeW5kzz6GZUTva2YzSl6uhGebXKtrPD8WCmxOMwm5HyaxLnmaWN55kigc
    kx8B5vPelnqZTxcx9RWRoCzprJATodqzWG1VvX2tZBamfgxt5WSSQQy4DmPzXYsJ
    Rd8l0HLRKfZQ7K8oF13jVoDgEk1FRADa2YMmZfcDg7zyqouUuksqVen5V78s5qX1
    U1gVsq0Tl4GDvxjdPO7yzTaps0gtzOrVvWLuUwlJCipk4FnaBovRBRALMPlf7Iz7
    JvzE5aB88tTJG9iJ02bUaDVG2lIM4wy1bNe0PE8axxq4lhji7GLP6jXcZVCxmB9J
    NWpNcNcGPPbF0tsaqGYIDjVG2VwxjJjDoh6cr5oFKCtyaUFDOBxjtHsGNNPl33SB
    GzYC8OvgertwNIxUI4f145rBerFzj0FCndZQsd4wyUQxKuiGFc5dbu0GR6m2dkHT
    ZEqsXZajUz5MrH5AZ3xOiwHKtBtcAcmTBIGUnEnBfo67GJU7kQXYBBhvubNVM4Ja
    XWZFQ6RiScQr4y1aOQrMfVzeOibU8AOcf5oskqVb2mdOKXpuk82CQdRR1wb0ODIy
    GDCF0yzvpbNiIMsbj6naAcPj2LWELztK9J3mcde9X3bdZUmUAAwCDIvjfXP1hAjP
    pIQo2guFzESWPiTDEJFlHz065y61rjr10PK28qtVVXkt8OsIwClZsa3UPhiEObTb
    DW5Lo39dZzxYJeQ94Q5thOY4Gn99bV2LIAgsoSfIGwWQJDQEVxyZDqSMs2cghlOl
    yzjggpLDFpS6Ezmwx30ORP4cMTg9zFCqumioeGn7Eh0fV6t3WjI8q69pxBZabsGp
    qKOruKfZvIoBUfP84y7YD3QfwV8D29puX0WZcE6CJQTivLRZBASaPSv8UiDAdEan
    8OKDi6eMQZsbIBZtEIl9tUcAuZBJRNmSEzCpfvXP9gRTVY9iMnHVVK3yGJw3Ilfn
    6oMhoaQU6NAaWoo1SbsumJ1VHtWb+WNXrpAESntDaFUStOTu8b84yA==
    -----END RSA PRIVATE KEY-----

Now use the command in your email to login to the jumphost, e.g.:

    $ ssh ec2-user@bastion.GUID.example.opentlc.com -i ~/.ssh/mylab

To make sure the right key is used, add `-i path/to/your/key` to the
command in the Email.

> **Note**
>
> Unless otherwise noted, you cannot use SSH to connect directly as
> root.

Setup SSH on Microsoft Windows
------------------------------

Analog to Linux/MacOS create a file e.g. named mylabkey.txt on your
Windows PC and copy the content of the private key into that file, incl.
header and footer line (see NOTE above)

### On Windows 10

You can open Powershell or Command window. Check if the ssh command is
available, which is now part of the Windows 10 packages. If you have ssh
available, you can login with

    C:\USERS\name> ssh ec2-user@bastion.GUID.example.opentlc.com -i ~/.ssh/mylabkey.txt

### PuTTY

If you use putty, you cannot directly import the SSH private key file.
You have to generate a so called ppk file to login with putty. To do
this you need the command PuTTYgen which you can download from the
[PuTTY download
page](http://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html)

1.  run PuTTYgen

2.  Click "Load" after "Load an existing private key file" and load the
    previously created keyfile

3.  Click the Save private key button to create the ppk file.

4.  Now you can Open PuTTY

5.  Add the generated ppk file to Connection → SSH → Auth → Private key
    file for authentication

see also: <https://my.justhost.com/hosting/help/putty#puttygen>

### MobaXterm

1.  open mobaXterm

2.  Click Session → SSH

3.  Enter Remote Host bastion.GUID.example.opentlc.com and User ec2-user

4.  click on Advanced SSH settings and enter the keyfile at "Use private
    key"

5.  click OK

SAP HANA on RHEL with Ansible
=============================

Introduction to Ansible roles
-----------------------------

In this chapter you will be introduced into the concept of ansible
roles.

An ansible role is a collection of tasks that are parametrized with
variables. Compared to programming languages they can be seen as
functions, that make playbooks more readable.

The complete description of roles can be found in [the Ansible Roles
documentation](https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_roles.html)

Red Hat is developing and supporting roles to make system admin tasks
easier and reproducable

You will learn how to use these roles in your playbooks e.g. to
configure

-   [Timeserver
    (chrony)](https://github.com/linux-system-roles/timesync)

-   [Hana Setup](https://github.com/linux-system-roles/sap-hana-prepare)
    according to the SAP Notes

-   and more

Find a list of currently supported roles and roles in technology preview
here: <https://access.redhat.com/articles/3050101>

Find additional roles build by the community here:
<https://galaxy.ansible.com/redhat_sap>

Check that Ansible is installed
-------------------------------

In the first part we will setup the bastion host as a simple admin
server.

1.  Update the bastion host: (replace $GUID by your GUID)

        # ssh ec2-user@bastion.$GUID.example.opentlc.com -i ~/.ssh/mylab
        # sudo -i
        # dnf -y update
        # reboot

2.  Connect to the control node (bastion) (replace $GUID by your GUID):

        # ssh ec2-user@bastion.$GUID.example.opentlc.com

3.  Check that Ansible is installed and usable:

        $ ansible --version
        ansible 2.9.11
          config file = /etc/ansible/ansible.cfg
          configured module search path = ['/home/ec2-user/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
          ansible python module location = /usr/lib/python3.6/site-packages/ansible
          executable location = /usr/bin/ansible
          python version = 3.6.8 (default, Oct 11 2019, 15:04:54) [GCC 8.3.1 20190507 (Red Hat 8.3.1-4)]

4.  Check that the environment variable GUID is set (xxxx is replaced
    bei your id):

        $ env| grep GUID
        GUID=xxxx

Check the Prerequisites
-----------------------

> **Note**
>
> Ansible is keeping configuration management simple. Ansible requires
> no database or running daemons and can run easily on a laptop. On the
> managed hosts it needs no running agent.

Verify that the managed hosts accept password-less connections with key
authentication from bastion as user ec2-user, e.g.:

    [ec2-user@bastion ~]$ ssh hana1
    [ec2-user@hana1 ~]$ exit

    [ec2-user@bastion ~]$ ssh hana2
    [ec2-user@hana2 ~]$ exit

To allow user ec2-user to execute commands on hana1 and hana2 as root
`sudo` needs to be configured on the managed hosts.

Test that the configuration allows ec2-user to run commands using `sudo`
on hana1 and hana2 without a password, e.g.:

    [ec2-user@bastion ~]$ ssh hana1
    [ec2-user@hana1 ~]$ sudo cat /etc/shadow
    [ec2-user@hana1 ~]$ exit

> **Note**
>
> **In all subsequent exercises you should work as the user ec2-user on
> the bastion host (jumphost) if not explicitly told differently.**

Create a working directory for playbooks and configuration files
----------------------------------------------------------------

Make sure you are user ec2-user on bastion. Create a directory for your
ansible files:

    [ec2-user@bastion ~]$ mkdir ansible-files

Configure the inventory
-----------------------

In this Lab the inventory is already configured globally in
`/etc/ansible/hosts` . The hana servers are in the group `hana`, the
S/4HANA server is named `s4hana`

-   Run `ansible all --list-hosts` — You will see an output similar to
    this:

        [ec2-user@bastion ansible-files]$ ansible all --list-hosts
          hosts (2):
            hana1.$GUID.internal
            hana2.$GUID.internal

-   Use ansible ping to check the connections from your management hosts

        [ec2-user@bastion ansible-files]$ ansible -m ping all
        hana1.$GUID.internal | SUCCESS => {
            "changed": false,
            "ping": "pong"
        }
        hana2.$GUID.internal | SUCCESS => {
            "changed": false,
            "ping": "pong"
        }

Install SAP HANA with ansible roles
-----------------------------------

### Check available roles for SAP deployment

On [Ansible Galaxy](http://galaxy.ansible.com) a lot of ready to use
roles exist. Red Hat maintaines the linux-system-roles, which are
upstream to supported RHEL System Roles.

See the follwoing pages for more details:

-   [Red Hat Enterprise Linux (RHEL) System
    Roles](https://access.redhat.com/articles/3050101)

-   [Linux System Roles
    (upstream)](https://galaxy.ansible.com/linux-system-roles/)

-   [Roles for SAP deployments
    (community)](https://galaxy.ansible.com/redhat_sap/)

Make sure you always have the latest SAP roles and rhel-system-roles
available. The current environment is running RHEL 8.1. Nonetheless
install the latest version of the roles. Use the following command to
install:

    yum update https://github.com/rhmk/sap-workshops/raw/gh-pages/sap-enablement-ansible/pkgs/rhel-system-roles-sap-2.0.0-7.el8.noarch.rpm
    yum install https://github.com/rhmk/sap-workshops/raw/gh-pages/sap-enablement-ansible/pkgs/rhel-system-roles-1.0-21.el8.noarch.rpm

Check that the above roles are installed and accessable on bastion as
user ec2-user. Get familiar with these roles and read the documentation
of each of the above role and browse the roles itself

    [ec2-user@bastion]$ ansible-galaxy list
    - sap-hana-preconfigure, (unknown version)
    - sap-netweaver-preconfigure, (unknown version)
    - sap-preconfigure, (unknown version)
    - linux-system-roles.kdump, (unknown version)
    - linux-system-roles.network, (unknown version)
    - linux-system-roles.postfix, (unknown version)
    - linux-system-roles.selinux, (unknown version)
    - linux-system-roles.storage, (unknown version)
    - linux-system-roles.timesync, (unknown version)
    - rhel-system-roles.kdump, (unknown version)
    - rhel-system-roles.network, (unknown version)
    - rhel-system-roles.postfix, (unknown version)
    - rhel-system-roles.selinux, (unknown version)
    - rhel-system-roles.storage, (unknown version)
    - rhel-system-roles.timesync, (unknown version)

> **Note**
>
> If you want to install an additional role from upstream use:
> `sudo ansible-galaxy install rolename -p /usr/share/ansible/roles`

To install multiple roles at once create a so called requirements file,
which contains all required roles. This file is also used by ansible
tower, to ensure all required roles are automatically installed.

1.  create a subdirectory roles in your working\_directory

        [ec2-user@bastion]$ cd ~/ansible-files
        [ec2-user@bastion]$ mkdir roles
        [ec2-user@bastion]$ cd roles

2.  create a file named `requirements.yml` in the roles subdirectory
    with the follwoing content

        # from Ansible Galaxy
        - src: redhat_sap.sap_rhsm 
          version: v1.1.2
        - src: redhat_sap.sap_hostagent
          version: v1.2.0
        - src: redhat_sap.sap_hana_deployment
          version:  v1.2.0
        - src: redhat_sap.sap_s4hana_deployment
          version:  v1.1.0
        - src: redhat_sap.sap_hana_hsr
          version: v1.2.0

3.  Install the roles

        [ec2-user@bastion]$ sudo ansible-galaxy install -r roles/requirements.yml -p /usr/share/ansible/roles

> **Note**
>
> Global roles can be installed (as root) to `/usr/share/ansible/roles`
> or `/etc/ansible/roles` using the -p option, per default roles are
> installed to `${HOME}/.ansible/roles`. You might need to set your
> roles\_path in `ansible.cfg` appropriately

For the installation of SAP HANA in this course we need the following
roles:

-   [rhel-system-roles.storage](https://galaxy.ansible.com/linux-system-roles/storage)

-   [rhel-system-roles.timesync](https://galaxy.ansible.com/linux-system-roles/timesync)

-   [sap-preconfigure](https://galaxy.ansible.com/berndfinger/sap_preconfigure)

-   [sap-hana-preconfigure](https://galaxy.ansible.com/berndfinger/sap_hana_preconfigure)

-   [sap\_rhsm](https://galaxy.ansible.com/redhat_sap/sap_rhsm)

-   [sap\_hostagent](https://galaxy.ansible.com/redhat_sap/sap_hostagent)

-   [sap\_hana\_deployment](https://galaxy.ansible.com/redhat_sap/sap_hana_deployment)

-   [sap\_s4hana\_deployment](https://galaxy.ansible.com/redhat_sap/sap_s4hana_deployment)

-   [sap\_hana\_hsr](https://galaxy.ansible.com/redhat_sap/sap_hana_hsr)

Click on each role above and read the README on how to use the roles and
study some example playbooks.

Create a playbook using roles to deploy hana
--------------------------------------------

To install SAP HANA with an ansible playbook you need to create a
playbook which complete the following steps. Some of these steps are
already completed in the setup phase, and can be skipped. Nonetheless
these steps are described here and possible roles are linked.

At this time you should be familiar with writing playbooks in ansible,
so that you just find the name of the role and the important variables
to set.

Take some time to think about, if the variables need to be designed set
at group or host level

> **Tip**
>
> You can click on the role names to display the documentation of the
> roles

### Register system to satellite or RHN

If you install a system from satellite this step is typically done with
an activation key so that there is no need to have a role for this.

The lab environment has a version of Red Hat Enterprise Linux 8.1
already installed, the repositories for HANA installation should be
configured correctly and the release should have been locked to 8.1.

If you setup a server in the field where this has not been configured
the following roles can help:

-   [sap\_rhsm](https://galaxy.ansible.com/redhat_sap/sap_rhsm) or

-   [subscribe-rhn](https://galaxy.ansible.com/mk-ansible-roles/subscribe-rhn)
    (more generic)

To ensure the proper subscription in this environment, we may use the
community role redhat\_sap.sap\_rhsm

1.  Read the [README of
    sap\_rhsm](https://galaxy.ansible.com/redhat_sap/sap_rhsm)

2.  As this is a test system the system is properly registered. Hence we
    do not need to provide registration credentials to the role. We can
    also live with the default settings for the repositories as well as
    pinning the OS to the underlying release.

    To make sure everything is set correctly, just run the role as it is
    without any parameters set.

> **Note**
>
> you will find more details on the Update Services for SAP in our
> [Knowledgebase](https://access.redhat.com/solutions/3075991)

### Configure timeserver

SAP requires proper time synchronisation. So the linux system role is a
proper way to set the time correctly

Use the
[`rhel-system-roles.timesync`](https://github.com/linux-system-roles/timesync/blob/master/README.md)
to configure your timeserver.  
Use the following parameter:

    timesync_ntp_servers:
            - hostname: 0.rhel.pool.ntp.org
              iburst: yes
    timesync_ntp_provider: chrony

> **Note**
>
> The timeserver module throws a couple errors that are ok to ignore

### Networking Setup

Network setup in this lab is already done. In other environments you
could use
[`rhel-system-roles.network`](https://github.com/linux-system-roles/network/blob/master/README.md)
to configure a more complex network preconfiguration. Nonetheless
`resolv.conf` on AWS is not reboot safe and will be overwritten. Instead
of using the network role the following line will make the changes to
DNS resolution persistent:

      pre_tasks:
        - name: Ensure sapdomain is in DNS search path
          nmcli:
            conn_name: "System eth0"
            type: ethernet
            dns4_search: "ec2.internal,{{ sap_domain }}"
            state: present
          tags:
                 - update_resolv

        - name: power cycle NetworkManager to rewrite resolv.conf
          service:
            name: NetworkManager
            state: restarted
          tags:
                 - update_resolv

> **Note**
>
> the tasks section will be run after the roles and the pre\_tasks
> section before the roles in an ansible playbook

### Disk configuration

If you login to hana1 or hana2 you will realize that the disks are not
configured. Use `lsblk` to identify unconfigured disks. For the
configuration of the disks use
[`linux-system-roles.storage`](https://github.com/linux-system-roles/storage/blob/master/README.md).  
Use the following parameters:

    storage_pools:
      - name: sap
        disks:
          - xvdf
        volumes:
          - name: data
            size: "128 GiB"
            mount_point: "/hana/data"
            fs_type: xfs
            state: present
          - name: log
            size: "64 GiB"
            mount_point: "/hana/log"
            fs_type: xfs
            state: present
          - name: shared
            size: "256 GiB"
            mount_point: "/hana/shared"
            fs_type: xfs
            state: present
          - name: sap
            size: "50 GiB"
            mount_point: "/usr/sap"
            state: present

> **Note**
>
> If you happen to misconfigure the disk, take your config and change
> the state to `absent`. Then rerun the storage configuration role to
> remove your setting, correct your entry, change the state to `present`
> again and rerun the storage configuration once more

### SAP preconfigure base settings:w

SAP requires a couple of base settings that are described in [SAP Note
2369910](https://launchpad.support.sap.com/#/notes/2369910) and other
SAP notes. The role
[`sap-preconfigure`](https://github.com/linux-system-roles/sap-preconfigure/blob/master/README.md)
will set the parameters that have to be set for all SAP software.

The role is designed to be used without parameters to produce a valid
output.

Please note that one requirement for SAP is, that the DNS setup is done
correctly. This is checked by the role and can also be fixed by the
role. As this can be destructive or if customers have other ways to
ensure proper DNS setup, the default is, that the role checks DNS only
and prints warnings if it is not set according to SAP requirements.

In our demo environment we want the role to update /etc/hosts with the
correct configuration. Hence we need to set the following variable:

    sap_preconfigure_modify_etc_hosts: true

In addition, if the public interface is different to the admin interface
the following variables can be set (not the case here):

-   `sap_hostname`: The hort hostname of the public IP of the SAP
    server. It defaults to *ansible\_hostname*

-   `sap_domain`: The DNS Domain of the SAP server. It defaults to
    *ansible\_fqdn*.

-   `sap_ip` : The IP address of the SAP server. It defaults to
    *ansible\_default\_ipv4.address*

In our demo environment no DNS domain is set and *ansible\_fqdn* is
empty, we need to set it to `$GUID.internal`. In Ansible we have the
option to access shell environment variables with the lookup function.
So set the variable for all systems like this

    sap_domain:  "{{ lookup('env', 'GUID') }}.internal"

The role is designed to stop with an error message in case the system is
updated and something has been installed that requires a reboot. The
reason for this is to properly react to the reboot situation and not to
reboot a production system immediately after updating. To avoid the
error, set the following variable:

    sap_preconfigure_update: yes
    sap_preconfigure_fail_if_reboot_required: false

> **Caution**
>
> The DNS setup of the servers is only tested and might not be
> completely correct. The role is not failing if DNS stup is not
> correct. It is recommended to have proper DNS in production, but it
> can work without it in test envrionments. In this environment you will
> see the following errors in the output after a reboot, if you didn’t
> make the resolv.conf persistent:

    TASK [sap-preconfigure : Check resolv.conf settings] **************************************************************************************************************************************************************
    fatal: [hana1]: FAILED! => {"changed": false, "cmd": "test \"$(dig hana1 +search +short)\" = \"192.168.0.138\"", "delta": "0:00:00.012347", "end": "2021-03-16 17:13:17.953316", "msg": "non-zero return code", "rc": 1, "start": "2021-03-16 17:13:17.940969", "stderr": "", "stderr_lines": [], "stdout": "", "stdout_lines": []}
    ...ignoring
    fatal: [hana2]: FAILED! => {"changed": false, "cmd": "test \"$(dig hana2 +search +short)\" = \"192.168.0.130\"", "delta": "0:00:00.013704", "end": "2021-03-16 17:13:18.069518", "msg": "non-zero return code", "rc": 1, "start": "2021-03-16 17:13:18.055814", "stderr": "", "stderr_lines": [], "stdout": "", "stdout_lines": []}
    ...ignoring
    fatal: [s4hana]: FAILED! => {"changed": false, "cmd": "test \"$(dig s4hana +search +short)\" = \"192.168.0.156\"", "delta": "0:00:00.014595", "end": "2021-03-16 17:13:18.163004", "msg": "non-zero return code", "rc": 1, "start": "2021-03-16 17:13:18.148409", "stderr": "", "stderr_lines": [], "stdout": "", "stdout_lines": []}
    ...ignoring

    TASK [sap-preconfigure : Check dns reverse settings] **************************************************************************************************************************************************************
    fatal: [hana1]: FAILED! => {"changed": false, "cmd": "test \"$(dig -x 192.168.0.138 +short)\" = \"hana1.d031.internal.\"", "delta": "0:00:00.012936", "end": "2021-03-16 17:13:18.744562", "msg": "non-zero return code", "rc": 1, "start": "2021-03-16 17:13:18.731626", "stderr": "", "stderr_lines": [], "stdout": "", "stdout_lines": []}
    ...ignoring
    fatal: [hana2]: FAILED! => {"changed": false, "cmd": "test \"$(dig -x 192.168.0.130 +short)\" = \"hana2.d031.internal.\"", "delta": "0:00:00.013366", "end": "2021-03-16 17:13:18.856884", "msg": "non-zero return code", "rc": 1, "start": "2021-03-16 17:13:18.843518", "stderr": "", "stderr_lines": [], "stdout": "", "stdout_lines": []}
    ...ignoring
    fatal: [s4hana]: FAILED! => {"changed": false, "cmd": "test \"$(dig -x 192.168.0.156 +short)\" = \"s4hana.d031.internal.\"", "delta": "0:00:00.013046", "end": "2021-03-16 17:13:18.950928", "msg": "non-zero return code", "rc": 1, "start": "2021-03-16 17:13:18.937882", "stderr": "", "stderr_lines": [], "stdout": "", "stdout_lines": []}
    ...ignoring

### SAP Hostagent installation

SAP installations will use SAP hostagent. The SAP hostagent is shipped
in different formats (RPM, tgz, sar). The role
[`redhat_sap.sap_hostagent`](https://github.com/redhat-sap/sap-hostagent/blob/master/README.md)
creates the user `sapadm` with groupid `sapsys` and installs or updates
the hostagent from the given path.

1.  Use the following variables to configure the hostagent with this
    role:

        # redhat_sap.sap_hostagent
        #------------------------------
        sap_hostagent_installation_type: "rpm"
        sap_hostagent_rpm_remote_path: "/software/SAPHOSTAGENT"
        sap_hostagent_rpm_file_name: "saphostagentrpm_44-20009394.rpm"

> **Tip**
>
> If you need to have reliable userid and groupid for `sapadm` and
> `sapsys` make sure to create the user and group prior to this role.

> **Note**
>
> This role has to be run in a play before running the HANA deployment,
> because the hostagent should be (re)started after an update or initial
> install. **Remember**: Handlers are executed at the end of the play
> not at the end of the role

### SAP HANA preconfiguration

To do all preconfiguration steps for SAP HANA which are described in a
couple of applicable SAP Notes use
[`sap_hana_preconfigure`](https://github.com/linux-system-roles/sap-hana-preconfigure/blob/master/README.md).

This role can be used without any additional parameters, although there
are some that might tweaked in production. e.g. some kernel parameters.
[SAP NOTE 238241](https://launchpad.support.sap.com/#/notes/238241),
defines a lot of kernel parameter options, that can be set, in the
variable `sap_hana_preconfigure_kernel_parameters`.

To get more information on the parameters read the description of the
role or have a look at
`/usr/share/ansible/roles/sap-hana-preconfigure/defaults/main.yml`

It is useful to set the following variable, to avoid an errors when
running this role and the system requires a reboot.

    sap_hana_preconfigure_fail_if_reboot_required: false

If you want to check and reboot the the system you can use the following
role:
[mk-ansible-roles.check\_reboot](https://galaxy.ansible.com/mk-ansible-roles/check_reboot)

### SAP HANA Deployment

Finally to install SAP HANA database, use the role
[`redhat_sap.sap_hana_deployment`](https://github.com/redhat-sap/sap-hana-deployment/blob/master/README.md).

This role creates the configuration file for an unattended install of
SAP HANA with `hdblcm` and kicks-off the installation process.

For this role you need to add the instance specific parameters in the
according `host_vars` or `group_vars` file:

    sap_hana_deployment_bundle_path: /software/HANA_installation
    sap_hana_deployment_bundle_sar_file_name: IMDB_SERVER20_046_0-80002031.SAR
    sap_hana_deployment_sapcar_path: /software/SAPCAR
    sap_hana_deployment_sapcar_file_name: SAPCAR_1311-80000935.EXE
    sap_hana_deployment_root_password: "R3dh4t123!"
    sap_hana_deployment_sapadm_password: "R3dh4t123!"
    sap_hana_deployment_hana_sid: RHE
    sap_hana_deployment_hana_instance_number: "00"
    sap_hana_deployment_hana_env_type: development
    sap_hana_deployment_hana_mem_restrict: "n"
    sap_hana_deployment_common_master_password: "R3dh4t123!"
    sap_hana_deployment_sidadm_password: "R3dh4t123!"
    sap_hana_deployment_hana_db_system_password: "R3dh4t123!"
    sap_hana_deployment_ase_user_password: "R3dh4t123!"
    sap_hana_deployment_apply_license: false

> **Caution**
>
> There are many cleartext passswords, which is OK for a training
> environment like this. In production environments these variables
> should be defined in an ansible vault file or as encrypted credentials
> in Ansibel tower.

Now create your var files and playbook to run the installation.

> **Tip**
>
> Take your time and add the variables to hostvars and groupvars
> directories accordingly

After the installation has finished, log into **hana1** and assume user
**rheadm** to see if SAP HANA is running. Your output should look
similar to this:

    [ec2-user@hana1 ~]# sudo su - rheadm
    Last login: Fri May 11 18:26:48 EDT 2018
    rheadm@hana1:/usr/sap/RHE/RHE00> HDB info
    USER          PID     PPID  %CPU        VSZ        RSS COMMAND
    rheadm      60667    60666   0.0      24420       4988 -sh
    rheadm      60768    60667   0.0      12960       3336  \_ /bin/sh /usr/sap/RHE/HDB00/HDB info
    rheadm      60799    60768   0.0      57184       3940      \_ ps fx -U rheadm -o user:8,pid:8,ppid:8,pcpu:5,vsz:10,rss:10,args
    rheadm       4409        1   0.0     448788      29172 /usr/sap/RHE/HDB00/exe/sapstartsrv pf=/usr/sap/RHE/SYS/profile/RHE_HDB00_hana1 -D -u rheadm
    rheadm       4343        1   0.0      93232       9596 /usr/lib/systemd/systemd --user
    rheadm       4345     4343   0.0     173324       2836  \_ (sd-pam)

Setup Hana SR
-------------

Now you have two identical SAP HANA databases running on hana1 and
hana2.

With the role
[redhat\_sap.sap\_hana\_hsr](https://galaxy.ansible.com/redhat_sap/sap_hana_hsr)
you can easily setup Hana System Replication between these instances.

Click on the link and read the README of the role to learn more about
the required variables.

The following variables need to be set for hana1 and hana2 in this lab:

    sap_hana_hsr_hana_sid: "RHE"
    sap_hana_hsr_hana_instance_number: "00"
    sap_hana_hsr_hana_db_system_password: "R3dh4t123!"
    sap_hana_hsr_hana_primary_hostname: "hana1"

While the folloing are individual per host:

-   On hana1 you need:

        sap_hana_hsr_role: "primary"
        sap_hana_hsr_alias: "DC1"

-   On hana2 you need:

        sap_hana_hsr_role: "secondary"
        sap_hana_hsr_alias: "DC2"

Now add the above variables to `host_vars` and `group_vars` variable
definitions and create a playbook using this role to setup HANA System
Replication.

> **Note**
>
> If you need some hints have a glimpse at the solutions paragraph

Once you have run your role, you can login to hana1 and check that the
system replication is running:

    ec2-user@bastion $ ssh hana1
    ec2-user@hana1 $ sudo su - rheadm
    rheadm@hana1:/usr/sap/RHE/HDB00> cdpy
    rheadm@hana1:/usr/sap/RHE/HDB00/exe/python_support> python ./systemReplicationStatus.py
    | Database | Host  | Port  | Service Name | Volume ID | Site ID | Site Name | Secondary | Secondary | Secondary | Secondary | Secondary     | Replication | Replication | Replication    |
    |          |       |       |              |           |         |           | Host      | Port      | Site ID   | Site Name | Active Status | Mode        | Status      | Status Details |
    | -------- | ----- | ----- | ------------ | --------- | ------- | --------- | --------- | --------- | --------- | --------- | ------------- | ----------- | ----------- | -------------- |
    | SYSTEMDB | hana1 | 30001 | nameserver   |         1 |       1 | DC1       | hana2     |     30001 |         2 | DC2       | YES           | SYNC        | ACTIVE      |                |
    | RHE      | hana1 | 30007 | xsengine     |         2 |       1 | DC1       | hana2     |     30007 |         2 | DC2       | YES           | SYNC        | ACTIVE      |                |
    | RHE      | hana1 | 30003 | indexserver  |         3 |       1 | DC1       | hana2     |     30003 |         2 | DC2       | YES           | SYNC        | ACTIVE      |                |

    status system replication site "2": ACTIVE
    overall system replication status: ACTIVE

    Local System Replication State
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    mode: PRIMARY
    site id: 1
    site name: DC1

Create a playbook to install S/4 Hana
-------------------------------------

You have now the Hana dabases running ready in System Replication

With the role
[redhat\_sap.sap\_s4hana\_deployment](https://galaxy.ansible.com/redhat_sap/sap-s4hana-deployment)
you can install SAP S/4HANA on these systems.

Before you use this role you have to run most of the roles you have
already run during the SAP HANA installation for:

-   System Registration to satellite or RHN (sap\_rhsm)

-   timeserver configurazion (rhel\_system\_roles.timesync)

-   networking setup

-   disk configuration (rhel\_system\_roles.storage)

-   SAP base configuration (sap\_preconfigure)

-   SAP hostagent installation (redhat\_sap.sap\_hostagent)

For most of the roles you need to use the same parameters and variables
that you have used for the HANA installation. Hence these parameters
should have been declared in the `group_vars/all` files.

The disk configuration (rhel\_system\_roles.storage) needs an indivdual
or different configuration than SAP HANA. In our lab use the following
variables to configure the disk of `s4hana`:

    ---
    # Individual storage config for S4/HANA
    # rhel-system-roles.storage
    #---------------------------

    storage_pools:
      - name: sap
        disks:
          - xvdf
        volumes:
          - name: sap
            size: "50 GiB"
            mount_point: "/usr/sap"
            state: present
          - name: sapmnt
            size: "20 GiB"
            mount_point: "/usr/sapmnt"
            state: present
          - name: swap
            size: "21 GiB"
            fs_type: swap
            mount_options: swap
            state: present

> **Caution**
>
> You need a rhel\_system\_role package version from RHEL 8.2 or newer.
> Otherwise the swapspace is not mounted automatically

> **Note**
>
> If you happen to misconfigure the disk, take your config and change
> the state to `absent`. Then rerun the storage configuration role to
> remove your setting, correct your entry, change the state to `present`
> again and rerun the storage configuration once more

In addition you need to run the following roles:

### SAP Netweaver preconfiguration

To do all preconfiguration steps for SAP Netweaver which are described
in SAP Note 2772999 for RHEL8 use
[`sap_netweaver_preconfigure`](https://github.com/linux-system-roles/sap-netweaver-preconfigure/blob/master/README.md).

This role can be used without any additional parameters. It
automatically fails, if not enough swap space is configured. So if you
have used a too old storage role, that could not mount the swap
partition, this will be detected in this step.

### SAP S/4 HANA installations

To install SAP S/4Hana use the role
[redhat\_sap.sap\_s4hana\_deployment](https://galaxy.ansible.com/redhat_sap/sap-s4hana-deployment)

The role automatically unpacks the SAP software runs the swpm installer
with a preconfigured configuration file. In this case we prepare a
single node S/4HANA instance. For more options see the README.

> **Note**
>
> In this particular case the DNS forward resolution is critical, so
> that DB host can be resolved

Use the following variables to install S/4HANA:

    # S4 HANA Installation
    # redhat_sap.sap_s4hana_deployment
    #-------------------------------------
    sap_s4hana_deployment_product_id: "NW_ABAP_OneHost:S4HANA1909.CORE.HDB.ABAP"
    sap_s4hana_deployment_sapcar_path: "/software/SAPCAR"
    sap_s4hana_deployment_sapcar_file_name: "SAPCAR_1311-80000935.EXE"
    sap_s4hana_deployment_swpm_path: "/software/S4HANA_installation"
    sap_s4hana_deployment_swpm_sar_file_name: "SWPM20SP04_6-80003424.SAR"
    sap_s4hana_deployment_db_schema_password: "R3dh4t123!"
    sap_s4hana_deployment_db_schema_abap_password: "R3dh4t123!"
    sap_s4hana_deployment_master_password: "R3dh4t123!"
    sap_s4hana_deployment_hana_systemdb_password: "R3dh4t123!"
    sap_s4hana_deployment_sid: "RHE"
    sap_s4hana_deployment_db_host: "hana1.{{ sap_domain }}"
    sap_s4hana_deployment_db_sid: "RHE"
    sap_s4hana_deployment_hana_instance_nr: "00"
    sap_s4hana_deployment_hana_system_password: "R3dh4t123!"
    sap_s4hana_deployment_parallel_jobs_nr: "30"
    sap_s4hana_deployment_db_sidadm_password: "R3dh4t123!"
    sap_s4hana_deployment_igs_path: "/software/S4HANA_installation"
    sap_s4hana_deployment_igs_file_name: "igsexe_9-80003187.sar"
    sap_s4hana_deployment_igs_helper_path: "/software/S4HANA_installation"
    sap_s4hana_deployment_igs_helper_file_name: "igshelper_17-10010245.sar"
    sap_s4hana_deployment_kernel_dependent_path: "/software/S4HANA_installation"
    sap_s4hana_deployment_kernel_dependent_file_name: "SAPEXEDB_201-80003385.SAR"
    sap_s4hana_deployment_kernel_independent_path: "/software/S4HANA_installation"
    sap_s4hana_deployment_kernel_independent_file_name: "SAPEXE_201-80003386.SAR"
    sap_s4hana_deployment_software_path: "/software/S4HANA_installation"
    sap_s4hana_deployment_sapadm_password: "R3dh4t123!"
    sap_s4hana_deployment_sap_sidadm_password: "R3dh4t123!"

> **Note**
>
> Please be patient. In this environment the deployment takes a while

Solution
--------

### You need to create the following playbook files:

1.  The required playbook to prepare the system for hana:
    `./prepare4sap.yml`:

        ---
        # This playbook configures all systems 
        # for consumption of SAP software

        - name: Prepare for SAP Install
          hosts: hana, s4hana
          become: yes

          pre_tasks:
            - name: Ensure sapdomain is in DNS search path
              nmcli:
                conn_name: "System eth0"
                dns4_search: "ec2.internal,{{ sap_domain }}"
                type: ethernet
                state: present
              tags:
                     - update_resolv

            - name: power cycle NetworkManager to rewrite resolv.conf
              service:
                name: NetworkManager
                state: restarted
              tags:
                     - update_resolv

          roles:
                      - redhat_sap.sap_rhsm
                      - linux-system-roles.timesync 
                      - linux-system-roles.storage
                      - sap-preconfigure
                      - redhat_sap.sap_hostagent

2.  The required playbook to install hana: `./install_hana.yml`:

        ---

        - name: Install Hana
          hosts: hana
          become: yes

          roles:
                      - sap-hana-preconfigure
                      - redhat_sap.sap_hana_deployment

3.  The required playbook to install S4: `./install_s4.yml`:

        ---

        - name: Install S4
          hosts: s4hana
          become: yes

          roles:
                      - sap-netweaver-preconfigure
                      - redhat_sap.sap_s4hana_deployment

4.  The required playbook to setup HANA System Replication:
    `./setup_hsr.yml`:

        ---

        - name: Setup SAP Hana System Replication 
          hosts: hana
          become: yes

          roles:
                      - redhat_sap.sap_hana_hsr

### The required variable files

1.  The variables that are required for all hosts: `./group_vars/all`

        # rhel-system-roles.timesync
        #---------------------------
        timesync_ntp_servers:
                - hostname: 0.rhel.pool.ntp.org
                  iburst: yes
        timesync_ntp_provider: chrony

        # sap-preconfigure
        #-------------------
        sap_preconfigure_modify_etc_hosts: true
        sap_domain: "{{ lookup('env', 'GUID') }}.internal"
        sap_preconfigure_update: yes
        sap_preconfigure_fail_if_reboot_required: false


        # redhat_sap.sap_hostagent
        #---------------------------
        sap_hostagent_installation_type: "rpm"
        sap_hostagent_rpm_remote_path: "/software/SAPHOSTAGENT"
        sap_hostagent_rpm_file_name: "saphostagentrpm_44-20009394.rpm"

2.  The variables that are required for all hana servers:
    `./group_vars/hana`

        # rhel-system-roles.storage
        #---------------------------
        storage_pools:
          - name: sap
            disks:
              - xvdf
            volumes:
              - name: data
                size: "128 GiB"
                mount_point: "/hana/data"
                fs_type: xfs
                state: present
              - name: log
                size: "64 GiB"
                mount_point: "/hana/log"
                fs_type: xfs
                state: present
              - name: shared
                size: "256 GiB"
                mount_point: "/hana/shared"
                fs_type: xfs
                state: present
              - name: sap
                size: "50 GiB"
                mount_point: "/usr/sap"
                state: present

        # sap-hana-preconfigure
        #--------------------------------
        sap_hana_preconfigure_fail_if_reboot_required: false

        # redhat_sap.sap_hana_deployment
        #--------------------------------
        sap_hana_deployment_bundle_path: /software/HANA_installation
        sap_hana_deployment_bundle_sar_file_name: IMDB_SERVER20_046_0-80002031.SAR
        sap_hana_deployment_sapcar_path: /software/SAPCAR
        sap_hana_deployment_sapcar_file_name: SAPCAR_1311-80000935.EXE
        sap_hana_deployment_root_password: "R3dh4t123!"
        sap_hana_deployment_sapadm_password: "R3dh4t123!"
        sap_hana_deployment_hana_sid: RHE
        sap_hana_deployment_hana_instance_number: "00"
        sap_hana_deployment_hana_env_type: development
        sap_hana_deployment_hana_mem_restrict: "n"
        sap_hana_deployment_common_master_password: "R3dh4t123!"
        sap_hana_deployment_sidadm_password: "R3dh4t123!"
        sap_hana_deployment_hana_db_system_password: "R3dh4t123!"
        sap_hana_deployment_ase_user_password: "R3dh4t123!"
        sap_hana_deployment_apply_license: false

3.  the required, individual variables for hana1: `./host_vars/hana1`

        # redhat_sap.sap_hana_hsr
        #=========================
        sap_hana_hsr_hana_sid: "RHE"
        sap_hana_hsr_hana_instance_number: "00"
        sap_hana_hsr_hana_db_system_password: "R3dh4t123!"
        sap_hana_hsr_hana_primary_hostname: "hana1"
        sap_hana_hsr_full_primary_hostname: "hana1.{{ sap_domain }}"
        sap_hana_hsr_full_secondary_hostname: "hana2.{{ sap_domain }}"
        sap_hana_hsr_role: "primary"
        sap_hana_hsr_alias: "DC1"

4.  the required, individual variables for hana1: `./host_vars/hana2`

        ---
        # redhat_sap.sap_hana_hsr
        #------------------------
        sap_hana_hsr_hana_sid: "RHE"
        sap_hana_hsr_hana_instance_number: "00"
        sap_hana_hsr_hana_db_system_password: "R3dh4t123!"
        sap_hana_hsr_hana_primary_hostname: "hana1"
        sap_hana_hsr_full_primary_hostname: "hana1.{{ sap_domain }}"
        sap_hana_hsr_full_secondary_hostname: "hana2.{{ sap_domain }}"
        sap_hana_hsr_role: "secondary"
        sap_hana_hsr_alias: "DC2"

5.  the required, individual variables for hana1: `./host_vars/s4hana`

        ---
        # Individual storage config
        # rhel-system-roles.storage
        #---------------------------

        storage_pools:
          - name: sap
            disks:
              - xvdf
            volumes:
              - name: sap
                size: "50 GiB"
                mount_point: "/usr/sap"
                state: present
              - name: sapmnt
                size: "20 GiB"
                mount_point: "/usr/sapmnt"
                state: present
              - name: swap
                size: "21 GiB"
                fs_type: swap
                mount_options: swap
                state: present

        # S4 HANA Installation
        # redhat_sap.sap_s4hana_deployment
        #-------------------------------------
        sap_s4hana_deployment_product_id: "NW_ABAP_OneHost:S4HANA1909.CORE.HDB.ABAP"
        sap_s4hana_deployment_sapcar_path: "/software/SAPCAR"
        sap_s4hana_deployment_sapcar_file_name: "SAPCAR_1311-80000935.EXE"
        sap_s4hana_deployment_swpm_path: "/software/S4HANA_installation"
        sap_s4hana_deployment_swpm_sar_file_name: "SWPM20SP04_6-80003424.SAR"
        sap_s4hana_deployment_db_schema_password: "R3dh4t123!"
        sap_s4hana_deployment_db_schema_abap_password: "R3dh4t123!"
        sap_s4hana_deployment_master_password: "R3dh4t123!"
        sap_s4hana_deployment_hana_systemdb_password: "R3dh4t123!"
        sap_s4hana_deployment_sid: "RHE"
        sap_s4hana_deployment_db_host: "hana1.{{ sap_domain }}"
        sap_s4hana_deployment_db_sid: "RHE"
        sap_s4hana_deployment_hana_instance_nr: "00"
        sap_s4hana_deployment_hana_system_password: "R3dh4t123!"
        sap_s4hana_deployment_parallel_jobs_nr: "30"
        sap_s4hana_deployment_db_sidadm_password: "R3dh4t123!"
        sap_s4hana_deployment_igs_path: "/software/S4HANA_installation"
        sap_s4hana_deployment_igs_file_name: "igsexe_9-80003187.sar"
        sap_s4hana_deployment_igs_helper_path: "/software/S4HANA_installation"
        sap_s4hana_deployment_igs_helper_file_name: "igshelper_17-10010245.sar"
        sap_s4hana_deployment_kernel_dependent_path: "/software/S4HANA_installation"
        sap_s4hana_deployment_kernel_dependent_file_name: "SAPEXEDB_201-80003385.SAR"
        sap_s4hana_deployment_kernel_independent_path: "/software/S4HANA_installation"
        sap_s4hana_deployment_kernel_independent_file_name: "SAPEXE_201-80003386.SAR"
        sap_s4hana_deployment_software_path: "/software/S4HANA_installation"
        sap_s4hana_deployment_sapadm_password: "R3dh4t123!"
        sap_s4hana_deployment_sap_sidadm_password: "R3dh4t123!"

### Running the playbooks

Now kick off the installation as user ec2-user on bastion:

> **Tip**
>
> run with -vv to increase debuglevel to get more information whats
> happening

1.  run the playbook to prepare all hosts for SAP software consumption

        [ec2-user@bastion ansible-files]$ ansible-playbook prepare4sap.yml

2.  Install SAP HANA on all hana servers

        [ec2-user@bastion ansible-files]$ ansible-playbook install-hana.yml

3.  Install SAP S/4hana

        [ec2-user@bastion ansible-files]$ ansible-playbook install-s4.yml

4.  Configure HANA System Replication

        [ec2-user@bastion ansible-files]$ ansible-playbook setup_hsr.yml

You finished your Lab deploying SAP HANA and S/4 HANA fully automated.
You now know the basics and should be able to integrate this with
Satellite or AnsibleTower. To learn more about these tools join us for
another ILT training or login to the [Partner
Portal](https://partnercenter.redhat.com) and look for appropriate OPEN
trainings

Bonus Labs
----------

### Upgrade HANA Server

Do you know how to upgrade SAP HANA servers

1.  with new RHEL patches?

2.  to a new RHEL minor release?

> **Warning**
>
> **Solution Below**

### Manual steps to update the OS of a HANA server

The following steps will update the OS of a single HANA server within a
RHEL major release. If the Server is using System Replication obiously
more steps are required but with the failover technology a fully
automated, near-zero downtime update can be achieved.

1.  Login as root to hana1

2.  Update the system to the latest patches in the current RHEL minor
    release:

    -   Make sure you have your release set to the current minor
        release:

            [root@hana1 ~]# subscription-manager release
            Release: 8.1

    -   OPTIONAL: If you want to update to a newer minor release you
        need to do this command additionally (see
        `subscription-manager release --list` for available releases):

            [root@hana1 ~]# subscription-manager release --set 8.2
            Release set to: 8.2

    -   Now you can update the system

            [root@hana1 ~]# yum -y update

3.  Now stop the HANA database

        [root@hana1 ~]# su - hxeadm
        hxeadm@hana1:/usr/sap/HXE/HDB90> HDB stop

4.  And reboot, if necessaey (e.g. new kernel)

        [root@hana1 ~]# reboot

5.  After reboot is finished, login and start HANA again (in case it is
    not started automatically)

        [root@bastion ~]# ssh hana1
        [root@hana1 ~]# su - hxeadm
          hxeadm@hana1:/usr/sap/HXE/HDB90> HDB start

### Automate these steps with Ansible

Do you really want to do this manually? If not, here is a playbook that
covers both upgrade scenarios. If you change `os_upgrade_release`, an
upgrade to another RHEL release will be performed.

1.  To use this playbook you need to install
    [`mk-ansible-roles.check_reboot`](https://galaxy.ansible.com/mk-ansible-roles/check_reboot)
    role:

        ec2-user@bastion $ sudo ansible-galaxy install mk-ansible-roles.check_reboot -p /usr/share/ansible/roles

2.  Playbook for updating a HANA server

        - name: Update Hana Server
          hosts: hana1
          become: yes

          vars:
                      os_release: 8.2
                      sid: RHE

          pre_tasks:
                      - name: Ensure correct OS release is set
                        shell: subscription-manager release --set "{{ os_release}}" && yum clean all
                        when: os_release != ansible_distribution_version

                      - name: ensure the the system is updated
                        yum: name=* state=latest

                      - name: ensure HANA is stopped
                        command: su - "{{ sid|lower + 'adm' }}" -c "HDB stop"

          roles:
                      - { role: mk-ansible-roles.check_reboot }

          tasks:
                      - name: ensure HANA is started
                        command: su - "{{ sid|lower + 'adm' }}" -c "HDB start"

> **Tip**
>
> You could also think about converting this playbook into separate
> roles, that can be reused in different playbooks, such as:
>
> -   Stop HANA instances
>
> -   Start HANA instances
>
> -   Update Server
>
> -   Reboot Server (already a role).
>
> Or extend the playbook to do a rolling update of the HANA cluster

### Additional commands that are useful for HANA system Replication to extend the playbook

The following commands may be useful for exting the above playbook. They
need to run in the conext of the HANA user, in our case `rheadm`

1.  unregistering a secondary node by logging to it (in this case
    hana2):

        hdbnsutil -sr_unregister

2.  register it again with

        hdbnsutil -sr_register

3.  You can monitor that the replication is deactivated with

        hdbnsutil -sr_state

4.  HANA system Replication takeover

        hdbnsutil -sr_takeover

5.  You get a lot of info using the python script
    `systemReplicationStatus.py`. The return value is 15 if everything
    is in sync.

Troubleshooting
===============

This section gives some hints on how to handle common problems

Check if HANA is running
------------------------

Please note, that after a reboot HANA is not started automatically,
which is by intention, login into the HANA host, assume the sidadm user
(which in our case is rheadm) and run `HDB info`

Start SAP HANA
--------------

Login into the HANA host, assume the sidadm user (which in our case is
rheadm) and run `HDB start`

Stop SAP HANA
-------------

Login into the HANA host, assume the sidadm user (which in our case is
rheadm) and run `HDB stop`

Check if an SAP system is installed
-----------------------------------

Login to an SAP system an run the following command
`/usr/sap/hostctrl/exe/saphostctrl -function GetCIMObject -enuminstances SAPInstance`

Or you can run the following playbook against your servers:

    - name: Check for SAP Instances
      hosts: all
      become: True
      tasks:
        - name:  Search for installed SAP Systems
          shell: |
            if [ -x /usr/sap/hostctrl/exe/saphostctrl ]; then
                  /usr/sap/hostctrl/exe/saphostctrl -function GetCIMObject -enuminstances SAPInstance
            fi
          register: sap_hana_deployment_sap_systems_list

        - name: Display installed SAP Systems
          debug:
              var: sap_hana_deployment_sap_systems_list

        - set_fact:
            installed_sid: "{{ item.split(',').2|trim }}"
          loop: "{{ sap_hana_deployment_sap_systems_list.stdout_lines|list }}"
          when: item is search("^ SID")

        - set_fact:
            installed_num: "{{ item.split(',').2|trim }}"
          loop: "{{ sap_hana_deployment_sap_systems_list.stdout_lines|list }}"
          when: item is search("^ SystemNumber")

        - set_fact:
            installed_typ: "{{ item.split(',').2|trim }}"
          loop: "{{ sap_hana_deployment_sap_systems_list.stdout_lines|list }}"
          when: item is search("^ InstanceName")


        - name: Display SID
          debug:
            msg: "SID is {{ installed_sid }}, Number {{ installed_num }}\nTyp {{ installed_typ}}"
          when: installed_sid is defined

        - name: Fail if you try to install HANA with same SID/Instance than other SAP system
          fail:
              msg: "There is a non-HANA software with the same SID/instance number running"
          when:
             - installed_typ is defined
             - installed_sid == sap_hana_deployment_hana_sid
             - installed_num == sap_hana_deployment_hana_instance_number
             - installed_typ != "HDB"+sap_hana_deployment_hana_instance_number

Cleanup the System to redo your installtion
-------------------------------------------

If you happen to run into new issues or have additional requests or
tipps, please report them
[here](https://github.com/rhmk/sap-workshops/issues). Please name the
"sap-enablement-ansible" workshop", when you open an issue

The End
=======

Congratulations, you finished your labs! We hope you enjoyed your first
steps deploying SAP with Ansible as much as we enjoyed creating the
labs.
