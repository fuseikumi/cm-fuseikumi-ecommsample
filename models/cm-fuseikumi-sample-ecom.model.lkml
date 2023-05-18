# Define the database connection to be used for this model.
connection: "cm_fuseikumi_sample_ecommerce"

# include all the views
include: "/views/**/*.view"

# Datagroups define a caching policy for an Explore. To learn more,
# use the Quick Help panel on the right to see documentation.

datagroup: cm-fuseikumi-sample-ecom_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: cm-fuseikumi-sample-ecom_default_datagroup

# Explores allow you to join together different views (database tables) based on the
# relationships between fields. By joining a view into an Explore, you make those
# fields available to users for data analysis.
# Explores should be purpose-built for specific use cases.

# To see the Explore you’re building, navigate to the Explore menu and select an Explore under "Cm-fuseikumi-sample-ecom"

# To create more sophisticated Explores that involve multiple views, you can use the join parameter.
# Typically, join parameters require that you define the join type, join relationship, and a sql_on clause.
# Each joined view also needs to define a primary key.

explore: products {}

explore: purchase_event {
  join: users {
    type: left_outer
    sql_on: ${purchase_event.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: shipped_order_items {
  join: users {
    type: left_outer
    sql_on: ${shipped_order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${shipped_order_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: users {}

explore: shipped_orders {
  join: users {
    type: left_outer
    sql_on: ${shipped_orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}
