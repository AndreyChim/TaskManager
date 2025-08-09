import routes from 'routes';
import FetchHelper from 'utils/fetchHelper';

export default {
  index(params) {
    const path = routes.apiV1TasksPath();
    return FetchHelper.get(path, params);
  },

  show(id) {
    const path = routes.apiV1TaskPath(id);
    return FetchHelper.get(path);
  },

  update(id, task = {}) {
    const path = routes.apiV1TaskPath(id);
    return FetchHelper.put(path, { task });
  },

  create(task = {}) {
    const path = routes.apiV1TasksPath();
    return FetchHelper.post(path, task);
  },

  destroy(id) {
    const path = routes.apiV1TaskPath(id);
    return FetchHelper.delete(path);
  },

   
  updatePosition(id, position) {
    return this.update(id, { position });
  },

  updateStatus(id, status) {
    return this.update(id, { status });
  },
};
