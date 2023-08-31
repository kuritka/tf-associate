tfsec:
	@echo "Running tfsec"
	@brew install tfsec
	tfsec

tflint:
	@echo "Running tflint"
	@brew install tflint
	tflint -f compact --recursive

tfmt:
	terraform fmt -recursive

check: tfmt tflint tfsec
