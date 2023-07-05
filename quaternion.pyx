# distutils: language = c++


cdef extern from "quaternion.h":
    cdef cppclass Quaternion:
        float w, x, y, z
        Quaternion(float, float, float, float)
        float dot(const Quaternion* q)
        int quaternionIsIdentity()
        Quaternion* quaternionMultiply(Quaternion* pOut,
								 const Quaternion* q1,
								 const Quaternion* q2)

cdef class PyQuaternion:

    cdef Quaternion *_thisptr
    
    def __cinit__(self, float _w, float _x, float _y, float _z):
        self._thisptr = new Quaternion(_w, _x, _y, _z)
        if self._thisptr == NULL:
            raise MemoryError()

    def __dealloc__(self):
        if self._thisptr != NULL:
            del self._thisptr
    
    def dot(self, PyQuaternion q):
        return self._thisptr.dot(q._thisptr)

    def isIdentity(self):
        return self._thisptr.quaternionIsIdentity()

    def multiply(self, PyQuaternion q):
        result = PyQuaternion(0,0,0,0)
        self._thisptr.quaternionMultiply(result._thisptr, self._thisptr, q._thisptr)
        return result
    
    @staticmethod
    def quaternionMultiply(PyQuaternion q1, PyQuaternion q2):
        result = PyQuaternion(0,0,0,0)
        q1._thisptr.quaternionMultiply(result._thisptr, q1._thisptr, q2._thisptr)
        return result

    @property
    def w(self):
        return self._thisptr.w
    
    @w.setter
    def w(self, value):
        self._thisptr.w = value
    
    @property
    def x(self):
        return self._thisptr.x
    
    @x.setter
    def x(self, value):
        self._thisptr.x = value 
    
    @property
    def y(self):
        return self._thisptr.y

    @y.setter
    def y(self, value):
        self._thisptr.y = value 
    
    @property
    def z(self):
        return self._thisptr.z

    @z.setter
    def z(self, value):
        self._thisptr.z = value 
    
