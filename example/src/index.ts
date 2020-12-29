console.log(`Spinning up...`);

export const handler = async (req: any, context: any) => {
  console.log("Request", req?.body ?? req);
  return {
    statusCode: 200,
    headers: {
      "x-custom-header" : "my custom header value"
    },
    body: JSON.stringify({
      handler: "ok!",
      req: req?.body ?? req
    })
  };
}