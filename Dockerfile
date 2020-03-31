################################################################################
# Netcool/Omnibus SNMP Probe
################################################################################

FROM netcool-omnibus-base:latest
LABEL maintainer="ybeisem@us.ibm.com"
LABEL version="21.0"
LABEL description="This is a Netcool/OMNIbus SNMP Probe image built using Netcool/OMNIbus base image."
LABEL netcool.omnibus.snmpprobe.version=21.0

USER netcool

ADD --chown=netcool:ncoadmin snmp_probe_21 /home/netcool/snmp_probe_21

RUN cd /home/netcool/snmp_probe_21 \
    && unzip -q omnbus-pb-nco-mttr*.zip \
    && cd /home/netcool/IBM/InstallationManager/eclipse/tools \
    && ./imcl -s -input /home/netcool/snmp_probe_21/snmp_probe_21.response.xml -acceptLicense \
    && ./imcl -s -input /home/netcool/snmp_probe_21/reset_repos.xml


WORKDIR /home/netcool
ENV HOME=/home/netcool \
    SHELL=/bin/bash \
    NCHOME=/opt/IBM/tivoli/netcool \
    OMNIHOME=/opt/IBM/tivoli/netcool/omnibus \
    PATH=/opt/IBM/tivoli/netcool/bin:/opt/IBM/tivoli/netcool/omnibus/bin:$PATH
ENTRYPOINT ["/bin/bash"]
