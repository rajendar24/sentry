/**
 * Autogenerated by Thrift Compiler (0.9.3)
 *
 * DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
 *  @generated
 */
package org.apache.sentry.hdfs.service.thrift;


import java.util.Map;
import java.util.HashMap;
import org.apache.thrift.TEnum;

public enum TPrivilegeEntityType implements org.apache.thrift.TEnum {
  ROLE(0),
  USER(1),
  AUTHZ_OBJ(2);

  private final int value;

  private TPrivilegeEntityType(int value) {
    this.value = value;
  }

  /**
   * Get the integer value of this enum value, as defined in the Thrift IDL.
   */
  public int getValue() {
    return value;
  }

  /**
   * Find a the enum type by its integer value, as defined in the Thrift IDL.
   * @return null if the value is not found.
   */
  public static TPrivilegeEntityType findByValue(int value) { 
    switch (value) {
      case 0:
        return ROLE;
      case 1:
        return USER;
      case 2:
        return AUTHZ_OBJ;
      default:
        return null;
    }
  }
}