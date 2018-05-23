<!--Container Based Execution Stack for Neural Networks / Benjamin Nussbaum / University of Vienna-->

<!--This thesis presents an execution stack for neural networks using the Kubernetes container orchestration and a Java based microservice architecture, which is exposed to users and other systems via RESTful webservices. The whole workflow including importing, training and evaluating a neural network model, becomes possible by using this service oriented approach. This work is influenced by N2Sky, a framework for the exchange of neural network specific knowledge and aims to support ViNNSL, the Vienna Neural Network Specification Language. The execution stack runs on many common cloud platforms. Furthermore it is scalable and each component is extensible and interchangeable. -->

# Introduction

This thesis presents an execution stack for neural networks using the *Kubernetes*[^0] container orchestration and a Java based microservice architecture, which is exposed to users and other systems via RESTful web services and a web frontend. The whole workflow including importing, training and evaluating a neural network model, becomes possible by using this service oriented approach (SOA). The presented stack runs on popular cloud platforms, like *Google Cloud Platform*[^1], *Amazon AWS*[^2] and *Microsoft Azure*[^3]. Furthermore it is scalable and each component is extensible and interchangeable. This work is influenced by N2Sky \cite{schikuta_2013}, a framework to exchange neural network specific knowledge and aims to support *ViNNSL*, the Vienna Neural Network Specification Language \cite{kopica_2015} \cite{beran_2008}. 

##### Objectives:

The first objective is to specify functional and non-functional requirements for the neural network system.  This is followed by the characterisation of the API and the implemention of microservices that later define the neural network composition as a collection of loosly coupled services.

The next step is to setup a *Kubernetes* cluster to create the foundation of container orchestration. 

Finally the microservices are deployed to containers and combined in a cluster. 

##### Non-Objectives: 

The prototype does not fully implement the *ViNNSL* in version 2.0, as described in \cite{kopica_2015} and provides limited data in-/output. Limitations are described in section TODO.

## Problem Statement

Getting started with machine learning and in particular with neural networks is not a trivial task. It is a complex field with a high entry barrier and requires most often programming skills and expertise in neural network frameworks. In most cases a complex setup is needed to train and evaluate networks, which is both a processor- and memory-intense job. With cloud computing getting more and more affordable and powerful, it makes sense to shift these tasks into the cloud. There are already existing cloud platforms for machine learning, but to my present research all of them do not fulfil at least one of the following criteria:

* platform is open-source
* no programming skills required to define and train a neural network model
* can be deployed on-site and and in the cloud (of your choice)
* components extensible and replaceable by developers
* provides a RESTful interface

This thesis showcases an architecture, that tries to achieve all of that.

 <!--TODO why it is important -->

<!--This thesis showcases an architecture, that is open-source and integrates with ViNNSL, a descriptive neural network language that does not require programming skills. It can run locally on every computer or in the cloud. All components are small microservices -- replaceable and extensible. REST services are provided which allows external services to integrate with the platform.-->



<!--What is the problem?-->
<!--Who has the problem?-->
<!--Where does the problem occur?-->
<!--When does the problem occur?-->
<!--How often does the problem occur?-->
<!--What causes the problem?-->
<!--What does the problem impact?-->

## Motivation

Machine learning has become a highly discussed topic in information technology in the past years and the trend is further increasing. It has become an essential part of everyday life when using search engines or speech recognition systems, like personal assistants. Self-learning algorithms in applications learn from the input of their users and decide which news an individual should read next, which song to listen to or which social media post should appear first. Messages are being analyzed and possible answers automatically predicted. 

A recent Californian study shows that 6.5 million developers worldwide are currently involved in projects that use artificial intelligence techniques and another 5.8 million developers expect to implement these in near future \cite{evans}.

Machine learning is not just a business area in the United States, survey results of 264 companies in the DACH region show, that 56 of them already use that kind of technology in production. In the near future 112 companies plan to do so or already have initial experiences (see figure \ref{img.crisp_ml_verbreitung}). It is seen by a fifth of the decision-makers as a core area to improve the competitiveness and profitability of companies in future. \cite{crisp}

<!--\bilds{crisp_ml_verbreitung}{Distribution of machine learning of 264 companies in the DACH region \cite{crisp}}{Distribution of machine learning in 264 companies (DACH region) \cite{crisp}}-->

![Distribution of machine learning of 264 companies in the DACH region \cite{crisp}\label{img.crisp_ml_verbreitung}](images/crisp_ml_verbreitung.png){width=10cm}

At the same time more and more companies shift their business logic from a monolithic design to microservices. Each service is dedicated to a single task that can be developed, deployed, replaced and scaled independently.  Test results have shown that not only this architecture can help reduce infrastructure costs \cite{villamizar2}\cite{villamizar}, but also reduces complexity of the code base and enables applications to dynamically adjust computing resources on demand \cite{villamizar}.

The presented project combines these techniques and demonstrates a prototype that is open-source and is supported by common cloud providers. Developers can integrate their own solutions into the platform or exchange components ad libitum.

It also integrates with ViNNSL, a descriptive language that does not require programming skills to define, train and evaluate neural networks.

## Structure

TODO

<!--Following the specification of ViNNSL by Kopica \cite{kopica_2015} this thesis provides a basic implementation of the markup language used to define the structure--> 

# State of the Art

## Containers

### Docker Containers

Containers enable software developers to deploy applications that are portable and consistent across different environments and providers \cite{baier-kub} by running isolated on top of the operating system's kernel \cite{bashari}. As an organisation, Docker[^4] has seen an increase of popularity very quickly, mainly because of its advantages, which are speed, portability, scalability, rapid delivery, and density \cite{bashari}.

Building a Docker container is fast, because images do not include a guest operating system. The container format itself is standardized, which means that developers only have to ensure that their application runs inside the container, which is then bundled into a single unit. The unit can be deployed on any Linux system as well as on various cloud environments and therefore easily be scaled. Not using a full operating system makes containers use less resources than virtual machines, which ensures higher workloads with greater density. \cite{joy2015}

## Microservices

The micoservice architecture pattern is a variant of a service-oriented architecture (SOA).  An often cited definition originates from Martin Fowler and James Lewis:

> In short, the microservice architectural style is an approach to developing a single application as a suite of small services, each running in its own process and communicating with lightweight mechanisms, often an HTTP resource API. These services are built around business capabilities and independently deployable by fully automated deployment machinery. There is a bare minimum of centralized management of these services, which may be written in different programming languages and use different data storage technologies. \cite{lewis2014microservices}

Figure \ref{monolithic_vs_microservice} shows the architectural difference between the monolithic and microservice architecture. Monolithic applications bundle user interface, data access layer and business logic together a single unit. In the microservice architecture each task has its own service. The user interface puts information together from multiple services.

![Monolithic Architecture vs. Microservice Architecture \label{monolithic_vs_microservice}](images/monolithic_vs_microservice.png){width=15cm}

## Container Orchestration Technologies

As every single microservice runs as a container, we need a tool to manage, organise and replace these containers. Services should also be able to speak to each other, be restarted if they fail. Services under heavy load should be scaled for better performance. To deal with these challenges container orchestration technologies come into place.  According to a study from 2017 published Portworx Kubernetes is the most frequently used container orchestration tool in organizations, followed by Docker Swarm and Kubernetes \cite{portworx-2017}

This section describes the architecture of the mentioned container orchestration technologies and compares them.

### Kubernetes

Kubernetes is the third container-management system (after Borg and Omega) developed by Google \cite{Burns:2016uq} for administering applications, that are provided in containers, in a cluster of nodes. Services that are responsible for controlling the cluster, are called master components \cite{kub_intro}. Figure \ref{kubernetes_core_architecture} shows the Kubernetes core architecture, which includes the Master server, the nodes and the interaction between the components.

![Kubernetes core architecture\label{kubernetes_core_architecture}](images/kubernetes_core_architecture.png){width=15cm}

#### Master Components

The master consists of the core API server, that provides information about the cluster and workload state and allows to define the desired state \cite{baier-kub}. The master server also takes care of scheduling and scaling workloads, cluster-wide networking and performs health checks \cite{kub_intro}. Workloads are managed in form of so-called pods, which are various containers that conclude the application stacks \cite{baier-kub}.

##### etcd

etcd is a key-value store, accessible by a HTTP/JSON API,  which can be distributed across multiple nodes and is used by Kubernetes to store configuration data, which needs to be accessible across nodes deployed in the cluster. It is essential for service discovery and to describe the state of the cluster, among other things. \cite{kub_intro}

etcd can also watch values for changes \cite{baier-kub}.

##### kube-apiserver

The API server acts as the main management point for the cluster and provides a RESTful interface for users and other services to configure workloads in the cluster. It is a bridge between other master components and is responsible of maintaining health and spreading commands in the cluster. \cite{kub_intro}

##### kube-scheduler

The scheduler keeps track of available and allocated resources on each specific node in the cluster. It has an overview of the infrastructure environment and needs to distribute workload to an acceptable node without exceeding the available resources. Therefore each workload has to declare its operating requirements. \cite{kub_intro}

##### kube-controller-manager

The controller manager mainly operates different controllers that constantly check the shared state of the cluster in `etcd` via the apiserver \cite{kub_comp} and if the current state differs towards the desired state it takes compensating measures \cite{kub_intro}. 

For example the node controller's task is to react when nodes go offline or down. The replication controller makes sure that the defined number of desired pods is identical to the number of currently deployed pods in the cluster and scales applications up or down accordingly. The endpoints controller populates the endpoints to services \cite{kub_comp} 

##### cloud-controller-manager

Kubernetes supports different cloud infrastructure providers. As each cloud providers has different features, apis and capabilities, cloud controller managers act as an abstraction to the generic internal Kubernetes constructs. This has the advantage that the core Kubernetes code is not dependent on cloud-provider-specific code. \cite{kub_comp} 

#### Node Components

Servers that accomplish workloads are called nodes. Each workload is described as one or more containers that have to be deployed. Node components run on every node in the cluster providing the Kubernetes runtime environment \cite{kub_comp}, that establishes networking and communicates with the master components. They also take care of deploying the necessary containers on a node and keep them running \cite{kub_intro}. Kubernetes requires a dedicated subnet for each node server and a supported container runtime \cite{kub_comp}.

##### kubelet

The kubelet is the primary agent running on each node in the cluster, responsible for running pods \cite{kub_comp}. It communicates with the API server to receive commands invoked by the scheduler. Interaction takes place with the etcd store to read and update configuration and state of the pod.

Pods are specified by the *PodSpec*, which defines the workload and parameters on how to run the containers \cite{kub_intro}. The kubelet process is responsible that the containers described in the specification are running and healthy \cite{kub_comp}. 

##### kube-proxy

The proxy service is in charge of forwarding requests of defined services to the correct containers. On a basic level, load balancing is also done by the proxy. \cite{baier-kub}

##### Container Runtime

The container runtime is an implementation running containers. Currently Docker, rkt, runc and OpenContainer runtimes are supported. \cite{kub_comp}

##### Pods

A pod is the smallest deployable unit in a cluster consisting of a group of one or more containers, which share network and storage. \cite{kub-pod}

#### Addons

##### Cluster DNS

Cluster DNS server keeps track of running services in the cluster and updates DNS records accordingly. This allows an easy way of service discovery. Containers include this DNS server in their DNS lookups automatically -- that way a service can resolve another service by its name. \cite{baier-kub}

##### Dashboard

The dashboard is a web-based user interface that allows to manage Kubernetes clusters and applications running in the cluster \cite{kub_comp}. It also provides access to log messages in each pod.

### Docker Swarm

On October 17, [Docker](https://www.docker.com/) announced that it will integrate [Kubernetes](https://kubernetes.io/) into the Docker platform. Users can chose to use [Kubernetes](https://www.docker.com/kubernetes) and/or [Docker Swarm](https://docs.docker.com/engine/swarm/) for orchestration. 

https://github.com/GuillaumeRochat/container-orchestration-comparison


## Machine Learning



*Machine learning—the process by which computers can get better at performing tasks through exposure to data, rather than through explicit programming—requires massive computational power, the kind usually found in clusters of energy-guzzling, cloud-based computer servers outfitted with specialized processors. But an emerging trend promises to bring the power of machine learning to mobile devices that may lack or have only intermittent online connectivity. This will give rise to machines that sense, perceive, learn from, and respond to their environment and their users, enabling the emergence of new product categories, reshaping how businesses engage with customers, and transforming how work gets done across industries.(https://www2.deloitte.com/insights/us/en/focus/signals-for-strategists/machine-learning-mobile-applications.html)*  TODO CITATION

### Classification

### Neural Networks

#### Tensorflow

#### DL4J

# Requirements

This section defines functional and non-function requirements of the developed prototype. The neural network execution stack focuses on two main target groups: data scientists and developers.  

Data scientists use the provided services in a deployed environment (cloud or own computer) to develop and train their neural networks. The system should be easy to setup and no programming knowledge should be needed to get started.  

Developers can extend the neural network stack with features or use the provided web services to implement their own custom solution. 

## Functional Requirements

Due to the fact that neural network training requires a lot of computing power, the main requirement is to design an architecture that can be executed in the cloud or on-site cluster hardware. 

To enable developers to extend the application, it is designed as a platform that is open-sourced and documented. An easy setup on a local computer and small micro-services with a clear structure and manageable code base make it easier to get acquainted with the architecture. 

The neural network platform should also offer a way to be extended or used by external applications and services, therefore a documented RESTful webservice is provided, that can be consumed by various clients. 

<!--TODO-->

<!--NN in Cloud Rechnen-->

<!--Verwendung der verständlichen Beschreibungssprache ViNNSl-->

<!--all Devices, from everywhere-->

<!--berechnetes Netzwerk kann in eig App verwendet werden / oder als Webservice exposed-->

### User Interface

The user interface shall be a web application that gives a quick overview of all neural networks and their training status. The frontend uses the RESTful API as backend source and does not cover the whole function range of the API. 

#### Mockup

Figure \ref{vinnsl-ui-mockup} shows a sketch of the user interface. On the left side the user can see a list of all created or imported neural networks. Next to the names of the networks, there is an icon representing the training status. In the detailed view on the right side, the title and id of the network is shown followed by an indicator when training is in progress. The visualisation of a neural network is divided into tabs.

The tabs "Description", "Definition", "Instance" and "Result" represent the eponymous ViNNSL Description XML file into a graphical tree view. When enough information is provided by ViNNSL XML files, the worker service performs a transformation into the internally used model representation of the DL4J Framework. The DL4J Tab shows the transformed object. In the "Files" tab, imported files of the storage services are listed and can be selected as training- or testset.

![Mockup: User Interface of Frontend Service\label{vinnsl-ui-mockup}](./images/vinnsl-ui-mockup.png){width=17cm}

## Non-Functional Requirements 

### Quality

The execution stack shall comply with the following quality features:

* Standard RESTful API
* the user interface works on all common browsers and devices (responsive design)
* loading time of the user interface should be less than three seconds

### Technical

### Software

- Kubernetes
- Docker

### Hardware

* Kubernetes compatible hardware or Cloud account (Amazon Web Services, Google Cloud Engine)

### Documentation

The documentation is provided in Section \ref{rest-api-documentation} or online on SwaggerHub (https://app.swaggerhub.com/apis/a00908270/).

### Source Code

The source code is released on GitHub https://github.com/a00908270

### Developer Environment

Developers can use any Java Based development environment. 



# Specification

## Use Case

Figure \ref{img.use_case_nn} shows the UML use case diagram. 

### Use Case Descriptions

<!--TODO (hinzufügen: dev: kann trainiertes netz in eigener app verwenden ,data scientist: trainiertes netzwerk exportieren und developer überreichen)-->



![UML Use Case Diagram \label{img.use_case_nn}](images/use_case_nn.png){width=15cm}

## Sequence Diagram

### Sequence of Training

TODO

Figure \ref{img.training_sequence} shows the sequence diagram. 

![Training Sequence Diagram \label{img.training_sequence}](images/training_sequence.png){width=15cm}

## Data Model Design

TODO

Figure \ref{img.db_schema} shows the data schema.

![NoSQL Data Model \label{img.db_schema}](images/db_schema.png){width=15cm}

## Overview Microservices

The neural network cloud execution stack consists of four main services that expose a RESTful API to users and two supporting services in charge of persisting data. Figure \ref{img.overview_main_services} shows an overview of these services.

### Vinnsl Service (vinnsl-service)

The `vinnsl-service` is responsible for handling the import, management and manipulation of neural network objects and it's status. It maps the CRUD[^5] operations to HTTP methods. A new neural network is created by sending a `POST` request to the `/vinnsl` endpoint containing a ViNNSL Definition XML as body. Sending a `GET` request to the `/vinnsl` route returns a JSON containing all ViNNSL neural network objects. 

The `vinnsl-service` depends on the `vinnsl-db` service, which runs a MongoDB database to store the objects. 

### Worker Service (vinnsl-nn-worker)

The `vinnsl-nn-worker` implements a queue management for neural network training and transforms ViNNSL neural network models into DL4J models. It provides a wrapper of the DL4J platform, that handles the training or evaluation of the network.

### Storage Service (vinnsl-storage-service)

Binary files, like trained network models, images or csv files are essential in the pocess of creating and training neural networks. File management is handled by the `vinnsl-storage-service`.

### Frontend UI (vinnsl-nn-ui)

The Frontend UI is a web application that gives a brief overview of all neural network models, their training status and linked files.

## User Interface Design

Auf Grundlage des ersten Sketches, wurde ein erstes Designmodell entwickelt.

Figure \ref{vinnsl-ui-design} shows the user interface design for the frontend web service.

![User Interface Design for vinnsl-nn-ui\label{vinnsl-ui-design}](images/vinnsl-ui-design.png){width=17cm}

## Service Discovery and Load Balancing



![Service Discovery with kube-dns](images/overview_main_services.png){width=15cm}

## Neural Network Objects

### State of Neural Network Objects

<!--\bild{nn-states}{15cm}{State Machine of a Neural Network}{State Machine of a Neural Network}-->

![State Machine of a Neural Network](images/nn-states.png){width=15cm}

## Class Diagram

### vinnsl-service

![Class Diagram of vinnsl-service](images/uml-class-diagram-vinnsl-service.png){width=17cm}

### vinnsl-storage-service

![Class Diagram of vinnsl-storage-service](images/uml-class-diagram-vinnsl-storage-service.png){width=15cm}

### vinnsl-worker-service

![Class Diagram of vinnsl-worker-service](images/uml-class-diagram-vinnsl-worker-service.png){width=17cm}

# REST API Documentation

##### Base URL

```
http[s]://<clusterip>
```

## vinnsl-service

### Import a new ViNNSL XML Defintion

```
POST /vinnsl
```

#### Parameters

| Type     | Name                   | Description | Schema |
| -------- | ---------------------- | ----------- | ------ |
| **Body** | **vinnsl**  *required* | vinnsl      | Vinnsl |

#### Responses

| HTTP Code | Description  | Schema     |
| --------- | ------------ | ---------- |
| **201**   | Created      | No Content |
| **500**   | Server Error | Error      |

#### Consumes

- `application/xml`

#### Produces

- `*/*`

#### Tags

- vinnsl-service-controller

#### Example HTTP request

##### Header

```
Content-Type: application/xml
```

##### Body

```
<vinnsl>
  <description>
    <identifier><!-- will be generated --></identifier>
    <metadata>
      <paradigm>classification</paradigm>
      <name>Backpropagation Classification</name>
      <description>Iris Classification Example</description>
      <version>
        <major>1</major>
        <minor>0</minor>
      </version>
    </metadata>
    <creator>
      <name>Ronald Fisher</name>
      <contact>ronald.fisher@institution.com</contact>
    </creator>
    <problemDomain>
      <propagationType type="feedforward">
        <learningType>supervised</learningType>
      </propagationType>
      <applicationField>Classification</applicationField>
      <networkType>Backpropagation</networkType>
      <problemType>Classifiers</problemType>
    </problemDomain>
    <endpoints>
      <train>true</train>
      <retrain>true</retrain>
      <evaluate>true</evaluate>
    </endpoints>
    <structure>
	   <input>
	    <ID>Input1</ID>
	    <size>
	    	<min>4</min>
	    	<max>4</max>
	    </size>
	   </input>
	   <hidden>
	    <ID>Hidden1</ID>
	    <size>
	    	<min>3</min>
	    	<max>3</max>
	    </size>
	   </hidden>
	   <hidden>
	    <ID>Hidden2</ID>
	    <size>
	    	<min>3</min>
	    	<max>3</max>
	    </size>
	   </hidden>
	   <output>
	    <ID>Output1</ID>
	    <size>
	    	<min>3</min>
	    	<max>3</max>
	    </size>
	   </output>
	 </structure>
	 <parameters/>
	 <data>
	 	<description>iris txt file with 3 classifications, 4 input vars</description>
	 	<tabledescription>no input as table possible</tabledescription>
	 	<filedescription>CSV file</filedescription>
	 </data>
  </description>
</vinnsl>
```
#### Example HTTP response

Statuscode: `201` CREATED

##### Header

```
Location: https://<baseURL>/vinnsl/5ade36bbd601800001206798
```

### List all Neural Networks

```
GET /vinnsl
```

#### Responses

| HTTP Code | Description  | Schema           |
| --------- | ------------ | ---------------- |
| **200**   | OK           | < Vinnsl > array |
| **404**   | Not Found    | No Content       |
| **500**   | Server Error | Error            |

#### Produces

- `application/json`

#### Tags

- vinnsl-service-controller

#### Example HTTP Response

```
[
    {
        "identifier": "5ab91658e8cc45946600ea11",
        "description": {},
        "definition": {},
        "data": {},
        "instance": {},
        "trainingresult": {},
        "result": {},
        "nncloud": {
            "status": "CREATED",
            "dl4jNetwork": "{}
        }
    },
    ...
]
```



### Delete all Neural Networks

```
DELETE /vinnsl/deleteall
```

#### Responses

| HTTP Code | Description  | Schema     |
| --------- | ------------ | ---------- |
| **200**   | OK           | object     |
| **204**   | No Content   | No Content |
| **500**   | Server Error | Error      |

#### Produces

- `application/json`

#### Tags

- vinnsl-service-controller

### Get Neural Network Object

```
GET /vinnsl/{id}
```

#### Parameters

| Type     | Name               | Description | Schema |
| -------- | ------------------ | ----------- | ------ |
| **Path** | **id**  *required* | id          | string |

#### Responses

| HTTP Code | Description | Schema     |
| --------- | ----------- | ---------- |
| **200**   | OK          | Vinnsl     |
| **404**   | Not Found   | No Content |

#### Produces

- `application/xml`
- `application/json`

#### Tags

- vinnsl-service-controller

#### Example HTTP response

```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<vinnsl>
    <identifier>5ab91658e8cc45946600ea11</identifier>
    <description>
        <identifier></identifier>
        <metadata>
            <paradigm>classification</paradigm>
            <name>Backpropagation Classification</name>
            <description>Face Recognition Example</description>
            <version>
                <major>1</major>
                <minor>5</minor>
            </version>
        </metadata>
        <creator>
            <name>Autor 1</name>
            <contact>author1@institution.com</contact>
        </creator>
        <problemDomain>
            <propagationType type="feedforward">
                <learningType>supervised</learningType>
            </propagationType>
            <applicationField>EMS</applicationField>
            <applicationField>Operations</applicationField>
            <applicationField>FaceRecoginition</applicationField>
            <networkType>Backpropagation</networkType>
            <problemType>Classifiers</problemType>
        </problemDomain>
        <endpoints>
            <train>true</train>
            <retrain>true</retrain>
            <evaluate>true</evaluate>
        </endpoints>
        <structure>
            <input>
                <ID>Input1</ID>
                <dimension>
                    <min>1</min>
                    <max>1</max>
                </dimension>
                <size>
                    <min>960</min>
                    <max>960</max>
                </size>
            </input>
            <hidden>
                <ID>Hidden1</ID>
                <dimension>
                    <min>1</min>
                    <max>1024</max>
                </dimension>
            </hidden>
            <output>
                <ID>Output1</ID>
                <dimension>
                    <min>1</min>
                    <max>1</max>
                </dimension>
                <size>
                    <min>1</min>
                    <max>1</max>
                </size>
            </output>
        </structure>
        <parameters/>
        <data>
            <description>Input are face images with 32x30 px</description>
            <tabledescription>no input as table possible</tabledescription>
            <filedescription>prepare the input as file by reading the image files</filedescription>
        </data>
    </description>
    <definition>
        <identifier></identifier>
        <problemDomain>
            <propagationType type="feedforward">
                <learningType>supervised</learningType>
            </propagationType>
            <applicationField>EMS</applicationField>
            <applicationField>Operations</applicationField>
            <applicationField>FaceRecoginition</applicationField>
            <networkType>Backpropagation</networkType>
            <problemType>Classifiers</problemType>
        </problemDomain>
        <endpoints></endpoints>
        <executionEnvironment>
            <serial>true</serial>
        </executionEnvironment>
        <structure>
            <input>
                <ID>Input1</ID>
                <dimension>1</dimension>
                <size>960</size>
            </input>
            <hidden>
                <ID>Hidden1</ID>
                <dimension>1</dimension>
                <size>1024</size>
            </hidden>
            <output>
                <ID>Output1</ID>
                <dimension>1</dimension>
                <size>1</size>
            </output>
            <connections/>
        </structure>
        <resultSchema>
            <instance>true</instance>
            <training>true</training>
        </resultSchema>
        <parameters>
            <valueparameter name="learningrate">0.4</valueparameter>
            <valueparameter name="biasInput">1</valueparameter>
            <valueparameter name="biasHidden">1</valueparameter>
            <valueparameter name="momentum">0.1</valueparameter>
            <comboparameter name="ativationfunction">sigmoid</comboparameter>
            <valueparameter name="threshold">0.00001</valueparameter>
            <comboparameter name="activationfunction">sigmoid</comboparameter>
        </parameters>
        <data>
            <description>Input are face images with 32x30 px</description>
            <dataSchemaID>iris.txt</dataSchemaID>
        </data>
    </definition>
    <data>
        <identifier>5ab4e69c8f136a16bf81f093</identifier>
        <data>
            <file>5ab4e69c8f136a16bf81f093</file>
        </data>
    </data>
</vinnsl>
```



### Remove Neural Network Object

```
DELETE /vinnsl/{id}
```

#### Parameters

| Type     | Name               | Description | Schema |
| -------- | ------------------ | ----------- | ------ |
| **Path** | **id**  *required* | id          | string |

#### Responses

| HTTP Code | Description  | Schema         |
| --------- | ------------ | -------------- |
| **200**   | OK           | ResponseEntity |
| **204**   | No Content   | No Content     |
| **500**   | Server Error | No Content     |

#### Produces

- `*/*`

#### Tags

- vinnsl-service-controller

### Add/Replace File of Neural Network

```
PUT /vinnsl/{id}/addfile
```

#### Parameters

| Type      | Name                   | Description | Schema |
| --------- | ---------------------- | ----------- | ------ |
| **Path**  | **id**  *required*     | id          | string |
| **Query** | **fileId**  *required* | fileId      | string |

#### Responses

| HTTP Code | Description  | Schema     |
| --------- | ------------ | ---------- |
| **200**   | OK           | Vinnsl     |
| **404**   | Not Found    | No Content |
| **500**   | Server Error | Error      |

#### Consumes

- `application/json`

#### Produces

- `application/xml`
- `application/json`

#### Tags

- vinnsl-service-controller

### Add/Replace ViNNSL Definition of Neural Network

```
PUT /vinnsl/{id}/definition
```

#### Parameters

| Type     | Name                | Description | Schema     |
| -------- | ------------------- | ----------- | ---------- |
| **Path** | **id**  *required*  | id          | string     |
| **Body** | **def**  *required* | def         | Definition |

#### Responses

| HTTP Code | Description  | Schema     |
| --------- | ------------ | ---------- |
| **200**   | OK           | Vinnsl     |
| **404**   | Not Found    | No Content |
| **500**   | Server Error | Error      |

#### Consumes

- `application/xml`
- `application/json`

#### Produces

- `*/*`

#### Tags

- vinnsl-service-controller

#### Example HTTP request

##### Request body

```
<definition>
<identifier><!-- will be generated --></identifier>
<metadata>
  <paradigm>classification</paradigm>
  <name>Backpropagation Classification</name>
  <description>Iris Classification Example</description>
  <version>
    <major>1</major>
    <minor>0</minor>
  </version>
</metadata>
<creator>
  <name>Ronald Fisher</name>
  <contact>ronald.fisher@institution.com</contact>
</creator>
<problemDomain>
  <propagationType type="feedforward">
    <learningType>supervised</learningType>
  </propagationType>
  <applicationField>Classification</applicationField>
  <networkType>Backpropagation</networkType>
  <problemType>Classifiers</problemType>
</problemDomain>
<endpoints>
  <train>true</train>
</endpoints>
<executionEnvironment>
	<serial>true</serial>
</executionEnvironment>
<structure>
   <input>
    <ID>Input1</ID>
    <size>4</size>
   </input>
   <hidden>
    <ID>Hidden1</ID>
    <size>3</size>
   </hidden>
   <hidden>
    <ID>Hidden2</ID>
    <size>3</size>
   </hidden>
   <output>
    <ID>Output1</ID>
    <size>3</size>
   </output>
   <connections>
   	<!--<fullconnected>
   		<fromblock>Input1</fromblock>
   		<toblock>Hidden1</toblock>
   		<fromblock>Hidden1</fromblock>
   		<toblock>Output1</toblock>
   	</fullconnected>-->
   </connections>
 </structure>
 <resultSchema>
 	<instance>true</instance>
 	<training>true</training>
 </resultSchema>
 <parameters>
 	<valueparameter name="learningrate">0.1</valueparameter>
	<comboparameter name="activationfunction">tanh</comboparameter>
	<valueparameter name="iterations">500</valueparameter>
	<valueparameter name="seed">6</valueparameter>
 </parameters>
 <data>
 	<description>iris txt file with 3 classifications, 4 input vars</description>
	<dataSchemaID>name/iris.txt</dataSchemaID>
 </data>
</definition>
```

### Add/Replace ViNNSL Instanceschema of Neural Network

```
PUT /vinnsl/{id}/instanceschema
```

#### Parameters

| Type     | Name                     | Description | Schema         |
| -------- | ------------------------ | ----------- | -------------- |
| **Path** | **id**  *required*       | id          | string         |
| **Body** | **instance**  *required* | instance    | Instanceschema |

#### Responses

| HTTP Code | Description  | Schema     |
| --------- | ------------ | ---------- |
| **200**   | OK           | object     |
| **404**   | Not Found    | No Content |
| **500**   | Server Error | Error      |

#### Consumes

- `application/xml`
- `application/json`

#### Produces

- `*/*`

#### Tags

- vinnsl-service-controller

#### Example HTTP request

##### Request body

```
<instanceschema>
</instanceschema>
```

### Add/Replace ViNNSL Resultschema of Neural Network

```
PUT /vinnsl/{id}/resultschema
```

#### Parameters

| Type     | Name                         | Description  | Schema       |
| -------- | ---------------------------- | ------------ | ------------ |
| **Path** | **id**  *required*           | id           | string       |
| **Body** | **resultSchema**  *required* | resultSchema | Resultschema |

#### Responses

| HTTP Code | Description  | Schema     |
| --------- | ------------ | ---------- |
| **200**   | OK           | object     |
| **404**   | Not Found    | No Content |
| **500**   | Server Error | Error      |

#### Consumes

- `application/xml`
- `application/json`

#### Produces

- `*/*`

#### Tags

- vinnsl-service-controller

#### Example HTTP request

##### Request body

```
<resultschema>
</resultschema>
```

### Add/Replace ViNNSL Trainingresult of Neural Network

```
PUT /vinnsl/{id}/trainingresult
```

#### Parameters

| Type     | Name                           | Description    | Schema               |
| -------- | ------------------------------ | -------------- | -------------------- |
| **Path** | **id**  *required*             | id             | string               |
| **Body** | **trainingresult**  *required* | trainingresult | Trainingresultschema |

#### Responses

| HTTP Code | Description  | Schema     |
| --------- | ------------ | ---------- |
| **200**   | OK           | object     |
| **404**   | Not Found    | No Content |
| **500**   | Server Error | Error      |

#### Consumes

- `application/xml`
- `application/json`

#### Produces

- `*/*`

#### Tags

- vinnsl-service-controller

#### Example HTTP request

##### Request body

```
<trainingresult>
</trainingresult>
```

### Get Status of all Neural Networks

```
GET /status
```

#### Responses

| HTTP Code | Description | Schema     |
| --------- | ----------- | ---------- |
| **200**   | OK          | object     |
| **404**   | Not Found   | No Content |

#### Produces

- `application/json`

#### Tags

- nn-status-controller

#### HTTP response example

```
{
    "5ab91658e8cc45946600ea11": "INPROGRESS"
}
```



### Get Status of Neural Network

```
GET /status/{id}
```

#### Parameters

| Type     | Name                 | Description | Schema |
| -------- | -------------------- | ----------- | ------ |
| **Path** | **id**    *required* | id          | string |

#### Responses

| HTTP Code | Description | Schema     |
| --------- | ----------- | ---------- |
| **200**   | OK          | object     |
| **404**   | Not Found   | No Content |

#### Produces

- `application/json`

#### Tags

- nn-status-controller

### Set Status of a Neural Network

```
PUT /status/{id}/{status}
```

#### Parameters

| Type     | Name                   | Description | Schema                                                |
| -------- | ---------------------- | ----------- | ----------------------------------------------------- |
| **Path** | **id**  *required*     | id          | string                                                |
| **Path** | **status**  *required* | status      | enum (`CREATED, QUEUED, INPROGRESS, FINISHED, ERROR`) |

#### Responses

| HTTP Code | Description  | Schema     |
| --------- | ------------ | ---------- |
| **200**   | OK           | object     |
| **404**   | Not Found    | No Content |
| **500**   | Server Error | Error      |

#### Consumes

- `application/json`

#### Produces

- `application/json`

#### Tags

- nn-status-controller

### Get Deeplearning4J Transformation Object of Neural Network

```
GET /dl4j/{id}
```

#### Parameters

| Type     | Name               | Description | Schema |
| -------- | ------------------ | ----------- | ------ |
| **Path** | **id**  *required* | id          | string |

#### Responses

| HTTP Code | Description | Schema     |
| --------- | ----------- | ---------- |
| **200**   | OK          | string     |
| **404**   | Not Found   | No Content |

#### Produces

- `application/json`

#### Tags

- dl4j-service-controller

### Put Deeplearning4J Transformation Object of Neural Network

```
PUT /dl4j/{id}
```

#### Parameters

| Type     | Name                 | Description | Schema |
| -------- | -------------------- | ----------- | ------ |
| **Path** | **id**  *required*   | id          | string |
| **Body** | **dl4J**  *required* | dl4J        | string |

#### Responses

| HTTP Code | Description  | Schema         |
| --------- | ------------ | -------------- |
| **200**   | OK           | ResponseEntity |
| **404**   | Not Found    | No Content     |
| **500**   | Server Error | Error          |

#### Consumes

- `application/json`

#### Produces

- `application/json`

#### Tags

- dl-4j-service-controller

## vinnsl-storage-service

### Handle File Upload from HTML Form
```
POST /storage
```


#### Parameters

|Type|Name|Description|Schema|
|---|---|---|---|
|**FormData**|**file**  <br>*required*|file|file|


#### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|OK|string|
|**201**|Created|No Content|
|**404**|Not Found|No Content|


#### Consumes

* `multipart/form-data`


#### Produces

* `\*/*`


#### Tags

* vinnsl-storage-controller


### List all Files
```
GET /storage
```


#### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|OK|[Model](#model)|
|**404**|Not Found|No Content|


#### Produces

* `application/json`


#### Tags

* vinnsl-storage-controller


### Download File by Original Filename
```
GET /storage/files/name/{filename}
```


#### Parameters

|Type|Name|Description|Schema|
|---|---|---|---|
|**Path**|**filename**  <br>*required*|filename|string|


#### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|OK|string (byte)|
|**404**|Not Found|No Content|


#### Produces

* `\*/*`


#### Tags

* vinnsl-storage-controller


### Download or Show File by FileID
```
GET /storage/files/{fileId}
```


#### Parameters

|Type|Name|Description|Schema|
|---|---|---|---|
|**Path**|**fileId**  <br>*required*|fileId|string|
|**Query**|**download**  <br>*optional*|download|boolean|


#### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|OK|string (byte)|
|**404**|Not Found|No Content|


#### Produces

* `\*/*`


#### Tags

* vinnsl-storage-controller


### Delete File by FileID
```
DELETE /storage/files/{fileId}
```


#### Parameters

|Type|Name|Description|Schema|
|---|---|---|---|
|**Path**|**fileId**  <br>*required*|fileId|string|


#### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|OK|ResponseEntity|
|**204**|No Content|No Content|
|**403**|Forbidden|No Content|


#### Produces

* `\*/*`


#### Tags

* vinnsl-storage-controller


### Get File Metadata by FileID
```
GET /storage/metadata/{fileId}
```


#### Parameters

|Type|Name|Description|Schema|
|---|---|---|---|
|**Path**|**fileId**  <br>*required*|fileId|string|


#### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|OK|< string, object > map|
|**404**|Not Found|No Content|


#### Produces

* `\*/*`


#### Tags

* vinnsl-storage-controller


### Upload MultipartFile
```
POST /storage/upload
```


#### Parameters

|Type|Name|Description|Schema|
|---|---|---|---|
|**FormData**|**file**  <br>*required*|file|file|


#### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|OK|object|
|**201**|Created|No Content|
|**404**|Not Found|No Content|


#### Consumes

* `multipart/form-data`


#### Produces

* `application/json`


#### Tags

* vinnsl-storage-controller


### Upload File by URL
```
GET /storage/upload
```


#### Parameters

|Type|Name|Description|Schema|
|---|---|---|---|
|**Query**|**url**  <br>*required*|url|string|


#### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|OK|object|
|**404**|Not Found|No Content|


#### Produces

* `application/json`


#### Tags

* vinnsl-storage-controller


## vinnsl-worker-service

### getWorkingQueue

```
GET /worker/queue
```

#### Responses

| HTTP Code | Description  | Schema           |
| --------- | ------------ | ---------------- |
| **200**   | OK           | < string > array |
| **401**   | Unauthorized | No Content       |
| **403**   | Forbidden    | No Content       |
| **404**   | Not Found    | No Content       |

#### Produces

- `\*/*`

#### Tags

- worker-controller

### addToWorkingQueue

```
PUT /worker/queue/{id}
```

#### Parameters

| Type     | Name                   | Description | Schema |
| -------- | ---------------------- | ----------- | ------ |
| **Path** | **id**  <br>*required* | id          | string |

#### Responses

| HTTP Code | Description  | Schema           |
| --------- | ------------ | ---------------- |
| **200**   | OK           | < string > array |
| **201**   | Created      | No Content       |
| **401**   | Unauthorized | No Content       |
| **403**   | Forbidden    | No Content       |
| **404**   | Not Found    | No Content       |

#### Consumes

- `application/json`

#### Produces

- `application/json`

#### Tags

- worker-controller


# Implementation of a Prototype 

## User Interface

<!--\bild{vinnsl-nn-ui}{15cm}{User Interface of Prototype}{User Interface of Prototype}-->

![User Interface of Prototype](images/VINNSL-NN-UI.png){width=15cm}

# Use Cases

1) iris classification

2) MNIST?

3) hosted trained network

# Future Work

TODO

* more function  
* backend für tensorflow
* grafischer NN designer
* trainierte netzwerke als webservice veröffentlichen
* integration in knime platform

# Conclusions 

# Acknowledgments 

# Dedication 

# Appendices

[^1]: https://cloud.google.com/kubernetes-engine
[^2]: https://aws.amazon.com/eks
[^3]: https://azure.microsoft.com/services/container-service
[^0]: https://kubernetes.io
[^4]: https://docker.com
[^5]: Create, Read, Update, Delete

