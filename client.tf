provider "aws" {
  region           = "ap-south-1"
  access_key       = "AKIASYUFT4SJALBZFVVD"        #for security purpose i have added incorrect key 
  secret_key       = "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"  #for security purpose i have added incorrect key 
}

resource "aws_instance" "web" {
  ami           = "ami-052c08d70def0ac62"
  instance_type = "t2.micro"
  key_name = "hadoopKey"
  security_groups = ["sg-00958f01bef689d16"]
  subnet_id = "subnet-091e7545"

  tags = {
    Name = "client-1"
  }
}

resource "null_resource" "nullremote3"  {

  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("C:/Users/ANSHIKA SHARMA/Downloads/hadoopKey.pem")
    host     = aws_instance.web.public_ip
  }

provisioner "remote-exec" {
    inline = [
      "sudo yum install git -y",
      "curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.rpm.sh | sudo bash",
      "sudo yum install git-lfs  -y",
      "sudo git lfs install",
      "sudo git-lfs clone https://github.com/Anshika-Sharma-as/hadoopClusterhadoop.git  /hdfs",
      "cd  /hdfs",
      "sudo mv jdk-8u171-linux-x64.rpm  /home/ec2-user",
      "cd",
      "sudo rm -rf /hdfs",
      "sudo git-lfs clone https://github.com/Anshika-Sharma-as/hadoopCluster.git  /hdfs",
      "cd  /hdfs",
      "sudo mv hadoop-1.2.1-1.x86_64.rpm  /home/ec2-user",
      "cd",
      "sudo rm -rf /hdfs",
      "cd /home/ec2-user",
      "sudo rpm -ivf jdk-8u171-linux-x64.rpm",
      "sudo rpm -ivh hadoop-1.2.1-1.x86_64.rpm --force",
      "cd /etc/hadoop",
      "sudo rm -rf core-site.xml",
      "cd",
      "sudo git clone https://github.com/rishabhjain1799/hadoop-slave.git  /hdfs",
      "cd /hdfs",
      "sudo mv core-site.xml /etc/hadoop",
      "sudo hadoop fs -touchz a.txt /"
    ]
  }
}

# 2nd client

resource "aws_instance" "web1" {
  ami           = "ami-052c08d70def0ac62"
  instance_type = "t2.micro"
  key_name = "hadoopKey"
  security_groups = ["sg-00958f01bef689d16"]
  subnet_id = "subnet-091e7545"

  tags = {
    Name = "client-2"
  }
}


resource "null_resource" "nullremote4"  {

  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("C:/Users/ANSHIKA SHARMA/Downloads/hadoopKey.pem")
    host     = aws_instance.web1.public_ip
  }


provisioner "remote-exec" {
    inline = [
      "sudo yum install git -y",
      "curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.rpm.sh | sudo bash",
      "sudo yum install git-lfs  -y",
      "sudo git lfs install",
      "sudo git-lfs clone https://github.com/Anshika-Sharma-as/hadoopClusterhadoop.git  /hdfs",
      "cd  /hdfs",
      "sudo mv jdk-8u171-linux-x64.rpm  /home/ec2-user",
      "cd",
      "sudo rm -rf /hdfs",
      "sudo git-lfs clone https://github.com/Anshika-Sharma-as/hadoopCluster.git  /hdfs",
      "cd  /hdfs",
      "sudo mv hadoop-1.2.1-1.x86_64.rpm  /home/ec2-user",
      "cd",
      "sudo rm -rf /hdfs",
      "cd /home/ec2-user",
      "sudo rpm -ivf jdk-8u171-linux-x64.rpm",
      "sudo rpm -ivh hadoop-1.2.1-1.x86_64.rpm --force",
      "cd /etc/hadoop",
      "sudo rm -rf core-site.xml",
      "cd",
      "sudo git clone https://github.com/rishabhjain1799/hadoop-slave.git  /hdfs",
      "cd /hdfs",
      "sudo mv core-site.xml /etc/hadoop",
      "sudo hadoop fs -touchz b.txt /"
    ]
  }
}
