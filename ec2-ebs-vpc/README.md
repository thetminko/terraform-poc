### Objective

This demo is on

- attach ebs volumn to ec2 in vpc created from ec2-vpc tutorial

To mount the new ebs,
mkfs.ext4 /dev/xvdh (the name in ebs attach)

mkdir /data
mount /dev/xvdh /data
