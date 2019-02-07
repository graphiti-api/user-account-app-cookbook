import { SpraypaintBase, Model, MiddlewareStack } from 'spraypaint'
import { IAuth } from '../auth'

@Model({
  baseUrl: `//${window.location.host}`,
  apiNamespace: '/api/v1'
})
export default class ApplicationRecord extends SpraypaintBase {
  static $auth: IAuth
}

let middleware = new MiddlewareStack()

middleware.afterFilters.push((response, json) => {
  if (response.status === 401) {
    ApplicationRecord.$auth.forceSignOut()
    throw("abort")
  }
})

ApplicationRecord.middlewareStack = middleware