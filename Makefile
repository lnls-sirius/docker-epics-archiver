DOCKER_REGISTRY ?= docker.io
DOCKER_USER_GROUP ?= lnlscon
DOCKER_IMAGE_PREFIX = $(DOCKER_REGISTRY)/$(DOCKER_USER_GROUP)

DATE = $(shell date -I)

LABELS += --label "br.com.lnls-sirius.department=GCS"
LABELS += --label "br.com.lnls-sirius.description=Archiver appliances"
LABELS += --label "br.com.lnls-sirius.maintener=Claudio Ferreira Carneiro"
LABELS += --label "br.com.lnls-sirius.repo=https://github.com/lnls-sirius/docker-epics-archiver-appliances"

EPICS_ARCHVIER_BASE_IMG = $(DOCKER_IMAGE_PREFIX)/epics-archiver-base
EPICS_ARCHVIER_BASE_TAG = tomcat9-jdk15-$(DATE)

EPICS_ARCHVIER_SINGLE_IMG = $(DOCKER_IMAGE_PREFIX)/epics-archiver-single
EPICS_ARCHVIER_SINGLE_TAG = $(EPICS_ARCHVIER_BASE_TAG)

TOMCAT_BASE_IMAGE = tomcat:9.0.43-jdk15-openjdk-buster

BUILD_ARGS_BASE += --build-arg TOMCAT_BASE_IMAGE=$(TOMCAT_BASE_IMAGE)
build-base:
	docker build $(LABELS) $(BUILD_ARGS_BASE)\
		--tag $(EPICS_ARCHVIER_BASE_IMG):$(EPICS_ARCHVIER_BASE_TAG) .


BUILD_ARGS_SINGLE += --build-arg EPICS_ARCHVIER_BASE_IMG=$(EPICS_ARCHVIER_BASE_IMG)
BUILD_ARGS_SINGLE += --build-arg EPICS_ARCHVIER_BASE_TAG=$(EPICS_ARCHVIER_BASE_TAG)
build-single:
	docker build $(LABELS) $(BUILD_ARGS_SINGLE)\
		--tag $(EPICS_ARCHVIER_SINGLE_IMG):$(EPICS_ARCHVIER_SINGLE_TAG) images-single/