
from lxml import etree
from os import listdir, path
from sys import argv
import argparse
import pathlib

class Validator:

    def __init__(self, xsd_path: str):
        xmlschema_doc = etree.parse(xsd_path)
        self.xmlschema = etree.XMLSchema(xmlschema_doc)

    def validate(self, xml_path: str) -> bool:
        xml_doc = etree.parse(xml_path)
        result = self.xmlschema.validate(xml_doc)

        return result

def dir_path(string):
    if path.isdir(string):
        return string
    else:
        raise NotADirectoryError(string)

if __name__=="__main__":

    schema_path = ''
    xml_file=''

    #read in args for path and file

    parser = argparse.ArgumentParser(description='Validate an XML against a XSD schema')
    parser.add_argument('schema', metavar='XML_Schema.xsd', type=pathlib.Path, nargs='+',
                        help='A schema to check against')
    parser.add_argument('xml_file', metavar='File.xml', type=pathlib.Path, nargs='+',
                        help='The xml file that is to be validated')

    args = parser.parse_args()

    #print(args.schema)

    #print(type(args.schema[0]))

    schema_path=args.schema[0]
    xml_file=args.xml_file[0]
    #validator=None

   # try:
    validator = Validator(schema_path)
    #except:
     #   print('No schema given.')

   
    
    if validator.validate(xml_file):
        print('Valid! :)')
    else:
        print('Not valid! :(')

