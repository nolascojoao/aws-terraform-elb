## Laboratório para Provisionamento de Load Balancer com Terraform

Laboratório em Terraform para provisionamento de uma VPC, subnets, EC2 com servidor web exibindo uma mensagem HTML personalizada e um Load Balancer na AWS. A mensagem HTML informa qual das duas instâncias EC2 está sendo acessada, com base no balanceamento de carga.


- [Para instalação do Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

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

---

## Prints


- `terraform init`


![terraform_init](https://github.com/user-attachments/assets/049fafae-32cb-401e-b836-b521acaf1e0e)


- `terraform validate`


![terraform_validate](https://github.com/user-attachments/assets/c7740aa2-fb50-4a75-9adb-01fba289d250)


- `terraform plan`

  
![terraform_plan](https://github.com/user-attachments/assets/b6c531d4-58b9-4545-b0c6-f98da6fb813c)

![terraform_plan2](https://github.com/user-attachments/assets/11b5d9e8-66fd-4c70-847f-b1f9974e94b2)


- `terraform apply -auto-approve`

  
![terraform_apply](https://github.com/user-attachments/assets/a62bf207-2e76-463b-898e-df5fb47bffd0)


- output

  
![output](https://github.com/user-attachments/assets/acf083f2-1fe7-428c-8988-cf73f80d6f4f)

![1](https://github.com/user-attachments/assets/ee294796-a669-4837-b696-b9067b681737)

![2](https://github.com/user-attachments/assets/2722a870-8b2e-4d37-aa73-d9a75aaa4355)


- `terraform destroy`


![terraform_destroy2](https://github.com/user-attachments/assets/7a794ab2-d2db-4845-9b1c-023de9299adc)

![terraform_destroy3](https://github.com/user-attachments/assets/8a37110f-2c0b-4fd3-b3e6-f4240b715f00)
