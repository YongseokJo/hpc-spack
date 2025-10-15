CL ?= perlmutter

.PHONY: setup install load run-native
setup:
	@bash scripts/use.sh $(CL)

install: setup
	@bash scripts/install_env.sh $(CL)

load:
	@. scripts/load_for_job.sh $(CL)

run-native:
	sbatch slurm/run_native.sp

