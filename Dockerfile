FROM progrium/cedarish
MAINTAINER lxfontes "lxfontes+slugbuilder@gmail.com"

ENV HOME /root
ADD ./slugbuilder /slugbuilder
RUN /slugbuilder/setup.sh
CMD ["/slugbuilder/slugbuilder"]
