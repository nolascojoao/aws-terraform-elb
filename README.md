## Laboratório para Provisionamento de Load Balancer com Terraform

Laboratório em Terraform para provisionamento de uma VPC, subnets, EC2 com servidor web exibindo uma mensagem HTML personalizada e um Load Balancer na AWS. A mensagem HTML informa qual das duas instâncias EC2 está sendo acessada, com base no balanceamento de carga.

#

```
aws-terraform-elb-/
├── main.tf
├── outputs.tf
├── providers.tf
├── variables.tf
└── .gitignore
```

---

## 🚀 Como Executar

**1. Inicialize o Terraform:**
```bash
terraform init
```

**2. Valide a configuração:**
```bash
terraform validate
```

**3. Planeje a execução:**
```bash
terraform plan
```

**4. Aplique a configuração:**
```bash
terraform apply -auto-approve
```

**5. Após a aplicação, copie o DNS do Load Balancer exibido na saída:**
```bash
Apply complete! Outputs:
elb_dns_name = "elb-lab-lb-xxxxxxxxx.elb.us-east-1.amazonaws.com"
```

**6. Acesse o DNS no navegador para ver a mensagem de boas-vindas.**

---

## 🚨 Para Deletar a Infraestrutura

**1. Certifique-se de estar na pasta onde estão os arquivos .tf.**

**2. Execute o comando:**
```bash
terraform destroy
```

**3. O Terraform pedirá uma confirmação. Digite `yes` para prosseguir.**
