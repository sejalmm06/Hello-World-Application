## Hello-World-Application README

#### Tools for CI/CD

The following tools will be utilized to implement CI/CD:

- **Git:** Serve as the version control system for effective code tracking and collaboration among developers.
- **Maven:** Use as a build automation tool to manage dependencies, compile code, and package the application.
- **Jenkins:** Orchestrate the CI/CD pipeline, managing build processes, test execution, and deployment to different environments.
- **Docker:** Containerize the application to ensure consistent deployment and minimize compatibility issues.
- **Ansible:** Automate infrastructure provisioning and configuration management for smooth application deployment.
- **Selenium:** Employ test automation with Selenium to verify the functionality and behavior of the deployed web application.
- **Terraform:** Enable infrastructure as code (IaC) by automating the provisioning and management of cloud resources, ensuring consistency and reproducibility in the infrastructure setup.
- **Kubernetes:** Enable running containerized applications in a managed cluster environment.
- **Prometheus & Grafana:** Provide powerful monitoring and visualization capabilities for efficient and comprehensive system monitoring.

### Implementation

#### Setting Up Infrastructure and Tools

**Step 1: EC2 Instances Creation**

- Three EC2 instances have been created on AWS: one for the master server and two for monitoring servers (Prometheus and Grafana).
- Security groups have been configured to allow all traffic to all instances.

  - **Master Server:**
    - jenkins server

  - **Monitoring Servers:**
    - Prometheus Server
    - Grafana Server

**Step 2: Master Server Setup**

- The master server has been set up by installing the necessary tools, including Git, Java 11, Maven, Jenkins, Docker, Ansible, and Terraform.
  
  - **Git:**
    - `sudo apt update`
    - `sudo apt install git`

  - **Java 11:**
    - `sudo apt update`
    - `sudo apt install openjdk-11-jdk`

  - **Maven:**
    - `sudo apt update`
    - `sudo apt install maven`
    - 
 - **Jenkins:**
    - `wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -`
    - `sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'`
    - `sudo apt update`
    - `sudo apt install jenkins`

    *Jenkins Setup:*
    - Open Jenkins on the browser: http://[Master Server IP]:8080
    - Retrieve the Jenkins initial admin password: `sudo cat /var/lib/jenkins/secrets/initialAdminPassword`
    - Install suggested plugins and set up an admin user.
      
![image](https://github.com/sejalmm06/Hello-World-Application/assets/129971092/aec2602d-32dd-4bc3-bad1-8f567f75af39)

  - **Ansible:**
    - `sudo apt update && sudo apt install ansible`

  - **Docker:**
    - `sudo apt update`
    - `sudo apt install docker.io -y`
    - `sudo systemctl enable docker`
    - `sudo systemctl start docker`
    
        *Permission Denied Issue:*
    ```
    sudo usermod -aG docker jenkins
    sudo visudo
    # Add the line below %sudo ALL=(ALL) NOPASSWD:ALL
    # Save and exit
    sudo systemctl restart jenkins
    sudo visudo -c
    sudo -u jenkins whoami
    ```

  - **Chromedriver:**
    - `sudo apt update && sudo apt install -y unzip xvfb libxi6 libgconf-2-4`
    - `sudo curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add`
    - `sudo echo "deb [arch=amd64]  http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list`
    - `sudo apt-get -y update`
    - `sudo apt-get -y install google-chrome-stable`
    - `sudo wget https://chromedriver.storage.googleapis.com/92.0.4515.107/chromedriver_linux64.zip`
    - `sudo unzip chromedriver_linux64.zip -d /usr/bin/`
    - `sudo chmod +x /usr/bin/chromedriver`

  - **Terraform:**
    - `sudo apt-get install unzip`
    - `wget https://releases.hashicorp.com/terraform/0.15.3/terraform_0.15.3_linux_amd64.zip`
    - `unzip terraform_0.15.3_linux_amd64.zip`
    - `sudo mv terraform /usr/local/bin/`

#### Step 3: Monitoring Server Setup
- Prometheus and Grafana servers have been set up on separate instances for monitoring the application and infrastructure.
- Prometheus has been configured to scrape metrics from the deployed application and Kubernetes cluster.
- Grafana has been configured to visualize the collected metrics from Prometheus.

  - Prometheus:
    - Installed using the following commands:
      ```bash
      sudo useradd --no-create-home --shell /bin/false prometheus
      sudo useradd --no-create-home --shell /bin/false node_exporter
      wget https://github.com/prometheus/prometheus/releases/download/v2.30.0/prometheus-2.30.0.linux-amd64.tar.gz
      tar -xvzf prometheus-2.30.0.linux-amd64.tar.gz
      sudo mv prometheus-2.30.0.linux-amd64 prometheus
      sudo mv prometheus /etc/
      sudo cp /etc/prometheus/prometheus.yml /etc/prometheus/prometheus.yml.backup
      sudo rm /etc/prometheus/prometheus.yml
      sudo mv /tmp/prometheus.yml /etc/prometheus/prometheus.yml
      sudo chown -R prometheus:prometheus /etc/prometheus
      sudo chmod -R 775 /etc/prometheus
      sudo mv prometheus.service /etc/systemd/system/prometheus.service
      sudo systemctl daemon-reload
      sudo systemctl start prometheus
      sudo systemctl enable prometheus
      ```
  - Node Exporter:
    - Installed using the following commands:
      ```bash
      wget https://github.com/prometheus/node_exporter/releases/download/v1.2.2/node_exporter-1.2.2.linux-amd64.tar.gz
      tar -xvzf node_exporter-1.2.2.linux-amd64.tar.gz
      sudo mv node_exporter-1.2.2.linux-amd64/node_exporter /usr/local/bin/
      sudo useradd --no-create-home --shell /bin/false node_exporter
      sudo chown node_exporter:node_exporter /usr/local/bin/node_exporter
      sudo mv node_exporter.service /etc/systemd/system/node_exporter.service
      sudo systemctl daemon-reload
      sudo systemctl start node_exporter
      sudo systemctl enable node_exporter
      ```

  - Grafana:
    - Installed using the following commands:
      ```bash
      sudo apt install -y software-properties-common
      sudo add-apt-repository -y "deb https://packages.grafana.com/oss/deb stable main"
      wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
      sudo apt update
      sudo apt install grafana
      sudo systemctl start grafana-server
      sudo systemctl enable grafana-server
      ```
    - Grafana has been accessed in a web browser using the public IP address of the Grafana server.
    - The default login credentials (admin/admin) have been used to log in.
    - A Prometheus data source has been added to Grafana, enabling it to fetch metrics from Prometheus.
    - A sample dashboard has been created to visualize the metrics collected by Prometheus.
   
   ### Step 4: Testing Server, Kubernetes Master, and Kubernetes Worker Creation

- Terraform is used to provision resources.
- `main.tf` file defines infrastructure resources.
- Initiate changes using Terraform commands.

### Testing Server Setup

- Prepare the testing server for application deployment.
- Configuration with Ansible.

### Kubernetes Cluster Setup

- Install Docker on nodes.
- Use kubeadm for Kubernetes installation.
- Configure master node, join worker nodes.
- Set up network overlay.
- Verify cluster status.

### IAM Role for EC2

- Create IAM role and attach it to an EC2 instance.
- Permissions and access policies are assumed by the EC2 instance.

## Jenkins Configuration

### Step 1: Plugin Installation

- Install necessary plugins in Jenkins.
  - Ansible, HTML Publisher, Artifactory, Terraform.

### Step 2: Global Tool Configuration

- Configure essential tools in the "Global Tool Configuration" section.
  - Maven, Git, Terraform, Ansible.

### Step 3 :Credentials Setup

- Navigate to the "Credentials" page in Jenkins.
- Add Docker Hub credentials and SSH keys for Ansible.

## #Step 4: Adding Kubernetes Master as Jenkins Slave

- Configure Jenkins to connect to the Kubernetes cluster.
- Utilize Kubernetes as a resource for builds and deployments.
<img src="https://github.com/sejalmm06/Hello-World-Application/assets/129971092/2b2a5a33-97c7-4ae8-b531-18682eea2976" alt="Image Alt Text" width="800" />

<img src="https://github.com/sejalmm06/Hello-World-Application/assets/129971092/2afb72d9-e1b9-476e-a892-0b1ac6b43b71" alt="Image Alt Text" width="800" />

### GitHub Repository Setup

#### Dockerfile ([Dockerfile](Dockerfile))
#### Ansible Playbook File ([ansible-playbook.yml](ansible-playbook.yml))
#### Ansible Hosts Inventory File ([hosts](hosts))
#### Deployment YAML ([deployment.yml](deployment.yml))
#### Service YAML ([service.yml](service.yml))
#### Pipeline Script:  ([Jenkinsfile](Jenkinsfile))
#### Selenium Test JAR File: [helloworld-runnable-jar.jar](helloworld-runnable-jar.jar)

**Process flow to create and upload helloworld-runnable-jar.jar**
- Selenium test scripts have been developed, compiled, and exported. They were then packaged into a JAR file using Maven.
- ![image](https://github.com/sejalmm06/Hello-World-Application/assets/129971092/eef7f0ed-3790-4d58-ac36-6303dc757336)
- The JAR file has been uploaded to the GitHub repository with a descriptive name and description.

  
### Pipeline Flow 

##### Stage 1: Checkout
This stage checks out the source code from the version control system.
##### Stage 2: Build
Builds the Maven project to compile and package the application.
##### Stage 3: Publish Test Reports
Publishes HTML test reports generated during the build process.
##### Stage 4: Image Prune
Cleans up unused Docker images.
##### Stage 5: Image Build
Builds a Docker image for the application.
##### Stage 6: Push to Docker Registry
Pushes the Docker image to the Docker registry.
##### Stage 7: Run on Test Server
Executes an Ansible playbook to deploy the application on a testing server.
##### Stage 8: Selenium Test
Runs Selenium tests on the deployed application.
##### Stage 9: Run on Prod Server
Deploys the application to a Kubernetes cluster 

### HelloApp Jenkins Pipeline Setup

- Created a pipeline project named HelloApp in Jenkins.
- Navigated to the Jenkins dashboard, selected "New Item," chose "Pipeline," and saved the project.
- ![image](https://github.com/sejalmm06/Hello-World-Application/assets/129971092/136e9a87-9854-44fd-9017-d164920aae5f)
- ![image](https://github.com/sejalmm06/Hello-World-Application/assets/129971092/b8b226b8-48c1-4b93-832f-1fd67f7e0d81)

- In the job configuration, the section for build triggers has been located. The webhook trigger option is enabled and selected in the build triggers section of the job configuration, ensuring that the job is automatically triggered based on specific events.
- ![image](https://github.com/sejalmm06/Hello-World-Application/assets/129971092/06e6f4f1-a07e-4904-8bab-18da27942ae0)
- ![image](https://github.com/sejalmm06/Hello-World-Application/assets/129971092/e17fd4c0-f0d3-400a-a5e1-952b5bfd135d)

### Pipeline Script:

- Refer to the [Jenkinsfile](Jenkinsfile) for the complete pipeline script.

## Run Pipeline   -

- The pipeline is automatically triggered by specific events or changes in the source code.
- **Full Stage View of Pipeline:**
  
![image](https://github.com/sejalmm06/Hello-World-Application/assets/129971092/39f46da6-3ae2-481f-a75e-5c7e5e55bcce)

## Console Outputs
![image](https://github.com/sejalmm06/Hello-World-Application/assets/129971092/2a154f5d-73ff-4e9d-9061-ddf089603910)


### Test Server Verification

- Verified the application after successful deployment on the test server.
![image](https://github.com/sejalmm06/Hello-World-Application/assets/129971092/3abf6b43-a8f9-4f51-816b-b1c3c35eaa0d)

### Production Server Verification

- Verified the application after successful deployment on the production server.
![image](https://github.com/sejalmm06/Hello-World-Application/assets/129971092/faa9b16e-a0d6-42b1-adcb-18ff0e58d962)


## Monitoring

### Node Exporter Installation

- Installed Node Exporter on the production server for system-level metric collection.
- Used the command: `apt update && apt install prometheus-node-exporter`
- Started Node Exporter service: `systemctl start prometheus-node-exporter`

### Prometheus Configuration

- Updated prometheus.yml file on the Prometheus server for scraping settings.
- Restarted Prometheus services: `systemctl restart Prometheus`

### Grafana Dashboard

- Configured Prometheus as a data source in Grafana.
- Created a Grafana dashboar for monitoring metrics.
- Configured panels for CPU utilization, Disk Space Utilization, and Total Available Memory.

