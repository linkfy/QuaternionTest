#ifndef __QUATERNION__
#define __QUATERNION__

struct Quaternion;

const float dotProduct(const Quaternion* q1, const Quaternion* q2);

struct Quaternion {
	Quaternion(float _w, float _x, float _y, float _z):
	w(_w), x(_x), y(_y), z(_z)
	{};

  float dot(const Quaternion* q) {
    return dotProduct(this, q);
  }


  Quaternion* quaternionMultiply(Quaternion* pOut,
								 const Quaternion* q1,
								 const Quaternion* q2)
  {
    pOut->w = q1->w * q2->w - q1->x * q2->x - q1->y * q2->y - q1->z * q2->z;
    pOut->x = q1->w * q2->x + q1->x * q2->w + q1->y * q2->z - q1->z * q2->y;
    pOut->y = q1->w * q2->y + q1->y * q2->w + q1->z * q2->x - q1->x * q2->z;
    pOut->z = q1->w * q2->z + q1->z * q2->w + q1->x * q2->y - q1->y * q2->x;

    return pOut;
  }

  const float dotProduct(const Quaternion* q1, const Quaternion* q2)
  {
    // A dot B = B dot A = AtBt + AxBx + AyBy + AzBz

    return (q1->w * q2->w +
        q1->x * q2->x +
        q1->y * q2->y +
        q1->z * q2->z);
  }

  int quaternionIsIdentity()
  {
    return (this->x == 0.0 && this->y == 0.0 && this->z == 0.0 &&
          this->w == 1.0);
  }


	float w,x,y,z;
};

#endif
