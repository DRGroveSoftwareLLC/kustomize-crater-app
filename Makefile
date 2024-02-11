CRATER_APP_VERSION := 6.0.6

$(CRATER_APP_VERSION).tar.gz:
	wget https://github.com/crater-invoice/crater/archive/refs/tags/$(CRATER_APP_VERSION).tar.gz

crater-$(CRATER_APP_VERSION):
	tar zxvf $(CRATER_APP_VERSION).tar.gz

.PHONY: images/crater-app-base/build
images/crater-app-base/build: $(CRATER_APP_VERSION).tar.gz crater-$(CRATER_APP_VERSION)
	docker build \
		--build-arg user=crater-user \
		--build-arg uid=1000 \
		-t drgrovellc/crater-app-base:$(CRATER_APP_VERSION) \
		crater-$(CRATER_APP_VERSION)

.PHONY: images/crater-app-base/build
images/crater-app/build: images/crater-app-base/build
	docker build \
		--build-arg user=crater-user \
		--build-arg CRATER_APP_VERSION=$(CRATER_APP_VERSION) \
		-t drgrovellc/crater-app:$(CRATER_APP_VERSION) \
		.

.PHONY: images/crater-app-nginx/build
images/crater-app-nginx/build:
	docker build \
		--build-arg user=crater-user \
		--build-arg CRATER_APP_VERSION=$(CRATER_APP_VERSION) \
		-t drgrovellc/crater-app-nginx:$(CRATER_APP_VERSION) \
		-f Dockerfile.nginx \
		.
