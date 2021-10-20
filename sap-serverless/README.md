# Exercise 4: Serverless Integration

Using Red Hat Integration Portfolio and Red Hat Openshift to integrate with SAP side-by-side using an event-driven system and OpenShift Serverless.

# Intro

This workshop can be used to demonstrate the integration capabilities for Red Hat Integration portfolio with SAP's Digital Core. 

![Infra layout](images/infra_layout.png)

Using Openshift Serverless we can build scenarios where we do not need to have pods running constantly and they will be only scaled up when they receive a request and once they have served it they will be scaled down again. The requests and their results once they are served will be the events in this scenario.

# Architecture

The Red Hat Integration component that allows for serverless integration is Camel K and Openshift has an operator to install it on an OCP cluster. You can look at the Installed Operators in your cluster and you will see it on the list. Go to `Administrator` view and then click on `Operators -> Installed Operators`

![Installed operators](images/installed_operators.png)

In this exercise we are going to integrate Slack with an SAP S/4HANA backend. We will ask about a sales order number on Slack and the SAP backend will receive this sales order number and return the details of the order back to the Slack channel we are using.

This is the process flow of the scenario:

![Serverless flow](images/serverless_flow.png)

Select the project `sap-serverless` in the `Administrator` view, change to `Developer` view and go to `Topology`

![Change Project](images/topology.gif)

There you can see all the components of the solution:

- Kamelet source that captures requests from Slack as events
- Channel where the sales order number received from Slack is sent to the Camel K application that integrates with the SAP S/4HANA backend
- Channel where the response from SAP with the data of the sales order is sent back
- Camel K application that sends the sales order number to SAP
- Camel K aplication that sends the details of the sales order from SAP back to Slack

# Steps

Connect to the `sales-order` channel created in Slack for this exercise https://redhat-sap-demos.slack.com/archives/C01R3NFP54H and keep open your Openshift console in the `Topology` section so that you can see how the pods scale up and down when the requests are received and served. If you are not familiar with Slack you can check the documentation on how to join a worksapce (https://slack.com/intl/en-gb/help/articles/212675257-Join-a-Slack-workspace) and a channel (https://slack.com/intl/en-gb/help/articles/205239967-Join-a-channel)

Type a valid sale order number in the Slack chat, for example any number between 500000001 and 500000099. You will be see then how the `sap-odata` pod where the application that sends the sales order number to SAP runs will scale up and then down once it has sent the information to SAP. After that, once the repsonse has been produced by the SAP backend, the `sap-sales-slack` pod will scale up as well so that it can send the response to the Slack channel and finally after some time you will see this response with the sales order details on the Slack chat. and the `sap-sales-slack` pod will be scaled down again.

![Slack response](images/slack.png)
