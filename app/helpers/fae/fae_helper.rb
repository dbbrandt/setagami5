module Fae
  module  FaeHelper

    def fae_add_button(item, add_path = nil, *custom_attrs)
      return if item.blank?
      add_path ||= polymorphic_path([main_app, fae_scope, item.try(:fae_parent), item]) + "/new"
      attrs = { title: 'Add', class: 'js-tooltip table-action' }
      attrs.deep_merge!(custom_attrs[0]) if custom_attrs.present?
      link_to add_path, attrs do
        concat content_tag :i, nil, class: 'icon-plus'
      end
    end

    def fae_edit_button(item, edit_path = nil, *custom_attrs)
      return if item.blank?
      edit_path ||= polymorphic_path([main_app, fae_scope, item.try(:fae_parent), item])+"/edit"
      attrs = { title: 'Edit', class: 'js-tooltip table-action' }
      attrs.deep_merge!(custom_attrs[0]) if custom_attrs.present?
      link_to edit_path, attrs do
        concat content_tag :i, nil, class: 'icon-edit'
      end
    end


  end
end
