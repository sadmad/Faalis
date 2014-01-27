require_dependency "faalis/application_controller"

module Faalis
  class API::V1::PermissionsController < APIController

    class DummyPerm
      attr_accessor :model, :permission_type
    end
    # GET /api/v1/permissions
    def index
      @permissions = []

      Faalis::Engine.models_with_permission.each do |model|
        model = Object.const_get(model)
        @permissions.concat(model::Permissions.permission_strings(model))
      end
      respond_with(@permissions)
    end

    def user_permissions
      @permissions = {}
      perms = []
      if current_user.group_id == 1
        Faalis::Engine.models_with_permission.each do |model|
          Object.const_get(model)::Permissions.possible_permissions.each do |p|
            perm = DummyPerm.new
            perm.model = model
            perm.permission_type = p
            perms << perm
          end
        end
      else
        perms = current_user.group.permissions
      end
      perms.each do |perm|
        if @permissions.include? perm.model
          @permissions[perm.model] << perm.permission_type
        else
          @permissions[perm.model] = [perm.permission_type]
        end
      end
      respond_with(@permissions)
    end

  end
end
