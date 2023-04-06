# LuaPlayer Modules

SUBDIRS = loadlib simple sound effect

.PHONY: dummy

# Use SUBDIRS to descend into subdirectories.
subdir_list = $(patsubst %,all-%,$(SUBDIRS))
subdir_clean = $(patsubst %,clean-%,$(SUBDIRS))
subdir_release = $(patsubst %,release-%,$(SUBDIRS))
subdirs: dummy $(subdir_list)

ifdef SUBDIRS
$(subdir_list): dummy
	$(MAKE) -C $(patsubst all-%,%,$@)
$(subdir_clean): dummy
	$(MAKE) -C $(patsubst clean-%,%,$@) clean
$(subdir_release): dummy
	$(MAKE) -C $(patsubst release-%,%,$@) release

endif

all: $(subdir_list)

clean: $(subdir_clean)
	rm -f *.lrx

release: $(subdir_release)

dummy:
 
