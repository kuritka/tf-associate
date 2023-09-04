tfsec:
	@echo "Running tfsec"
	@brew install tfsec
	# tfsec doesnt support import blocks yet: https://github.com/aquasecurity/tfsec/issues/2070#issuecomment-1669056215
	tfsec --ignore-hcl-errors

tflint:
	@echo "Running tflint"
	@brew install tflint
	tflint -f compact --recursive

tfmt:
	terraform fmt -recursive

check: tfmt tflint tfsec
	terraform -chdir=./environments/dev/eu-west/ init
	terraform -chdir=./environments/dev/eu-west/ validate
	terraform -chdir=./environments/dev/us-east/ init
	terraform -chdir=./environments/dev/us-east/ validate

include ./.platform/colima.mk
