declare module "@salesforce/apex/ObjectMetadataController.getObjectNames" {
  export default function getObjectNames(): Promise<any>;
}
declare module "@salesforce/apex/ObjectMetadataController.getFieldName" {
  export default function getFieldName(param: {objectName: any}): Promise<any>;
}
declare module "@salesforce/apex/ObjectMetadataController.getFieldsData" {
  export default function getFieldsData(param: {objectApiName: any, Fields: any}): Promise<any>;
}
declare module "@salesforce/apex/ObjectMetadataController.getdata" {
  export default function getdata(param: {objectApiName: any}): Promise<any>;
}
