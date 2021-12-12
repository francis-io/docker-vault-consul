FROM python:3.11-rc-alpine

 # Install before code so it wont reinstall every time i edit the app and reduce file sprawl
RUN pip install flask

COPY app.py /
#WORKDIR /

ENTRYPOINT ["python"]
CMD ["app.py"]