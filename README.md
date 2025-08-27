# Deploy A Static Website Using Terraform
This project will create an S3 bucket configured for static website hosting.  The site files will be uploaded via Terraform.
## 1 - Prerequites (on your machine or Codespace)
- AWS account & access key (access key id + secret) with permission to create S3 buckets & policies.
- Terraform installed (recommended v1.x). If you’re in a Codespace you can install Terraform with the official binary (or use the HashiCorp Codespace feature).
- `aws` CLI (optional but useful) — configure with `aws configure` or export env vars.
- Git and a GitHub repo to push to.
## 2 - Project layout (create this locally or in Codespace)
<img width="249" height="278" alt="Screen Shot 2025-08-26 at 10 32 24 PM" src="https://github.com/user-attachments/assets/31bd05e8-a03a-4b87-a0bf-4d7a654637b1" /> <br>
Create the folder:
- mkdir -p ~/static-website-terraform/site ~/static-website-terraform/terraform
- cd ~/static-website-terraform
## 3 - Add a tiny sample website
- `site/index.html`
