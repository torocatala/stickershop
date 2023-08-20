import { useQuery, gql } from '@apollo/client';

const PRODUCTS_QUERY = gql`
  query GetProducts {
    products {
      name
      price
      description
      imageUrl
    }
  }
`;

function ProductsListGraphql() {
  const { loading, error, data } = useQuery(PRODUCTS_QUERY);

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error: {error.message}</p>;

  return (
    <div>
      {data.products.map((product) => (
        <div key={product.id}>
          <h3>{product.name}</h3>
          <p>{product.description}</p>
          <p>{product.price}</p>
          <img src={product.imageUrl} alt={product.name} />
        </div>
      ))}
    </div>
  );
}

export default ProductsListGraphql;