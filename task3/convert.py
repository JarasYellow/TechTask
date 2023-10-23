import json
import xml.etree.cElementTree as extree

with open("input.json") as json_format_file:
    data = json.load(json_format_file)

employee = extree.Element("Employee")

extree.SubElement(employee, "Fullname").text = data["fullname"]

characteristics = extree.SubElement(employee, "Characteristics")

extree.SubElement(characteristics, "Sex").text = data["characteristics"]["sex"]
extree.SubElement(characteristics, "Age").text = str(data["characteristics"]["age"])

skills = extree.SubElement(employee, "Skills")

for skill in data["skills"]:
    extree.SubElement(skills, "Skill").text = skill

experiences = extree.SubElement(employee, "Experiences")

for exp in data["experience"]:
    experience = extree.SubElement(experiences, "Experience")
    extree.SubElement(experience, "Position").text = exp["position"]
    extree.SubElement(experience, "Workplace").text = exp["workplace"]
    if "salary" in exp:
        extree.SubElement(experience, "Salary").text = exp["salary"]
    if "id_card" in exp:
        extree.SubElement(experience, "ID_Card").text = str(exp["id_card"])
    if "Country" in exp:
        extree.SubElement(experience, "Country").text = exp["Country"]

a = extree.ElementTree(employee)

a.write("json_to_xml.xml")