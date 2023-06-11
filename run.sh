cd terraform
terraform init
terraform apply

if [ $? -nq 0 ]
then
    echo "Error During Terraform Execution, Failed Run!"
    exit $?
fi

cd ..

bastion_host_ip=$(awk -F= '{if($1=="bastion_host_ip") {print $2;exit}}' outputs.txt)
cluster_name=$(awk -F= '{if($1=="cluster_name") {print $2;exit}}' outputs.txt)

if [[ ! $bastion_host_ip || ! $cluster_name ]]
then
    echo "Empty Variables, Failed Run!"
    exit 1
fi

cat > ansible/inventory <<EOF
[bastion]
$bastion_host_ip
EOF

echo "The inventory has been updated!"
echo "Starting Playbook Now..."

ansible-playbook ansible/playbook.yml -e "cluster_name=${cluster_name}" --ask-vault-pass

